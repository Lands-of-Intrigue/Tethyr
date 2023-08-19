import sys
import subprocess
import os
import shutil
import time
import multiprocessing
from os.path import join

# usage is:
#     python module_packer.py path/to/module.mod src


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
        print('ERROR - unrecognized command. Use pack or unpack.')
    # clean up
    # shutil.rmtree(tempDir)
    print(f'{command} complete')


def unpack(modulePath, targetDir, tempDir):
    if not os.path.isfile(modulePath):
        print(f'ERROR - invalid path to module {modulePath}')
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
        elif ext != '.ncs':            
            gffFiles.append(f)

    # Greedily try to use all of the cores except for one
    p = multiprocessing.Pool(multiprocessing.cpu_count() - 1) 

    print('Converting gff files')
    convertTic = time.perf_counter()
    converter = Converter(targetDir, tempDir)
    p.map(converter.from_gff, gffFiles)
    convertToc = time.perf_counter()
    print(f'Converted gff files in {convertToc - convertTic:0.1f}s')

    print('Copying script files')
    copyTic = time.perf_counter()
    copier = Copier(tempDir, targetDir)
    p.map(copier.copy, scriptFiles)
    copyToc = time.perf_counter()
    print(f'Copied script files {copyToc - copyTic:0.1f}s')


def pack(modulePath, sourceDir, tempDir):
    if os.path.isfile(modulePath) or os.path.isdir(modulePath):
        print(f'ERROR - already exists {modulePath}')
        return
    absModule = os.path.abspath(modulePath)

    gffFiles = []
    scriptFiles = []
    for f in os.listdir(sourceDir):
        ext = os.path.splitext(f)[1]
        if ext == '.nss':
            scriptFiles.append(f)
        elif ext != '':
            gffFiles.append(f)

    # Greedily try to use all of the cores except for one
    p = multiprocessing.Pool(multiprocessing.cpu_count() - 1) 

    print('Compiling scripts')
    compileTic = time.perf_counter()
    compiler = Compiler(sourceDir, tempDir)
    p.map(compiler.compile, scriptFiles)
    compileToc = time.perf_counter()
    print(f'Compiled scripts in {compileToc - compileTic:0.1f}s')

    print('Converting gff files')
    convertTic = time.perf_counter()
    converter = Converter(sourceDir, tempDir)
    p.map(converter.to_gff, gffFiles)
    convertToc = time.perf_counter()
    print(f'Converted gff files in {convertToc - convertTic:0.1f}s')

    print('Copying script files')
    copyTic = time.perf_counter()
    copier = Copier(sourceDir, tempDir)
    p.map(copier.copy, scriptFiles)
    copyToc = time.perf_counter()
    print(f'Copied script files {copyToc - copyTic:0.1f}s')

    print(f'Packing {absModule}')
    packTic = time.perf_counter()
    p = subprocess.Popen(['nwn_erf', '-e', 'MOD', '-f', modulePath, '-c', tempDir])
    p.wait()
    packToc = time.perf_counter()
    print(f'Packed module to {absModule} in {packToc - packTic:0.1f}s')


class Copier:
    def __init__(self, fromDir, toDir):
        self.fromDir = fromDir
        self.toDir = toDir

    def copy(self, file):
        shutil.copyfile(join(self.fromDir, file), join(self.toDir, file))


class Converter:
    def __init__(self, srcDir, tempDir):
        self.srcDir = srcDir
        self.tempDir = tempDir

    def from_gff(self, file):
        outputJson = file + '.json'
        p = subprocess.Popen(['nwn_gff', '-i', join(self.tempDir, file), '-o', join(self.srcDir, outputJson), '-p'])
        p.wait()

    def to_gff(self, file):
        outputGff = os.path.splitext(file)[0]
        p = subprocess.Popen(['nwn_gff', '-i', join(self.srcDir, file), '-o', join(self.tempDir, outputGff)])
        p.wait()


class Compiler:
    def __init__(self, srcDir, tempDir):
        self.srcDir = srcDir
        self.tempDir = tempDir

    def compile(self, file):
        p = subprocess.Popen(['nwnsc', '-lq', '-b', self.tempDir, '-i', self.srcDir, join(self.srcDir, file)])
        p.wait()


if __name__ == "__main__":
    main()