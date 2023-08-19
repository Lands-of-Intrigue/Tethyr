import sys
import subprocess
import os
import shutil
import time
import multiprocessing
from os.path import join

TEMP_DIR = 'temporary'

def main():
    command = str(sys.argv[1])
    module = str(sys.argv[2])
    targetDir = str(sys.argv[3])

    print(f'Command is to {str(sys.argv[1])}')
    if not os.path.isdir(targetDir):
        print(f'Invalid path to target dicretory {targetDir}')
        return
    
    tempDir = join(targetDir, TEMP_DIR)
    if os.path.isdir(tempDir):
        shutil.rmtree(tempDir)
    os.mkdir(tempDir)

    if command == 'pack':
        pack(module, targetDir, tempDir)
    elif command == 'unpack':
        unpack(module, targetDir, tempDir)
    else:
        print('Unrecognized command. Use pack or unpack.')

    # clean up
    shutil.rmtree(tempDir)
    print(f'{command} complete')

def unpack(modulePath, targetDir, tempDir):
    if not os.path.isfile(modulePath):
        print(f'Invalid path to module {modulePath}')
        return
    absModule = os.path.abspath(modulePath)

    print(f'Unpacking {absModule}')
    unpackTic = time.perf_counter()
    p = subprocess.Popen(['nwn_erf', '-f', absModule, '-x'], cwd=tempDir)
    p.wait()
    unpackToc = time.perf_counter()
    print(f'Unpacked module to {tempDir} in {unpackToc - unpackTic:0.1f}s')

    gffFiles = []
    scriptFiles = []
    for f in os.listdir(tempDir):
        ext = os.path.splitext(f)[1]
        if ext == '.nss':
            scriptFiles.append(f)
        elif ext == '.ncs':
            continue
        else:
            gffFiles.append(f)

    # Greedily try to use all of the cores except for one
    p = multiprocessing.Pool(multiprocessing.cpu_count() - 1) 

    print('Converting gff files')
    convertTic = time.perf_counter()
    converter = Converter(targetDir, tempDir)
    p.map(converter.from_gff, gffFiles)
    convertToc = time.perf_counter()
    print(f'Converted gff files in {convertToc - convertTic:0.1f}s')

    print('Moving script files')
    moveTic = time.perf_counter()
    mover = Mover(tempDir, targetDir)
    p.map(mover.move, scriptFiles)
    moveToc = time.perf_counter()
    print(f'Moved script files {moveToc - moveTic:0.1f}s')

def pack(modulePath, targetDir, tempDir):
    print(f'Packing {targetDir}')
    p = subprocess.Popen(['nwn_erf', '-e', 'MOD', '-f', modulePath, '-c', targetDir])
    p.wait()
    print(f'Packed module to {modulePath}')


class Mover:
    def __init__(self, fromDir, toDir):
        self.fromDir = fromDir
        self.toDir = toDir

    def move(self, file):
        os.replace(join(self.fromDir, file), join(self.toDir, file))


class Converter:
    def __init__(self, srcDir, tempDir):
        self.srcDir = srcDir
        self.tempDir = tempDir

    def from_gff(self, file):
        outputJson = file + '.json'
        p = subprocess.Popen(['nwn_gff', '-i', join(self.tempDir, file), '-o', join(self.srcDir, outputJson), '-p'])
        p.wait()


if __name__ == "__main__":
    main()