import sys
import subprocess
import os
import shutil
import time
import multiprocessing
import yaml
from os.path import join
from pathlib import Path

# usage is:
#     python module_packer.py pack
#     python module_packer.py unpack

def main():
    command = str(sys.argv[1])

    config = yaml.safe_load(open("packer_settings.yaml"))
    targetDir = Path(config['root'])

    print(f'Command is to {str(sys.argv[1])}')
    if not os.path.isdir(targetDir):
        print(f'Invalid path to target dicretory {targetDir}')
        return
    
    tempDir = Path(config['temp'])
    if os.path.isdir(tempDir):
        shutil.rmtree(tempDir)
    os.mkdir(tempDir)

    modulePacker = ModulePacker(config['os'], targetDir, tempDir)
    if command == 'pack':
        modulePacker.pack(Path(config['module']['to']))
    elif command == 'unpack':
        modulePacker.unpack(Path(config['module']['from']))
    else:
        print('ERROR - unrecognized command. Use pack or unpack.')
    # clean up
    shutil.rmtree(tempDir)
    print(f'{command} complete')


class ModulePacker:
    def __init__(self, os, targetDir, tempDir):
        self.nwn_erf = join('lib', os, 'nwn_erf')
        self.nwn_gff = join('lib', os, 'nwn_gff')
        self.nwnsc = join('lib', os, 'nwnsc')
        self.targetDir = targetDir
        self.tempDir = tempDir

    def unpack(self, modulePath):
        if not os.path.isfile(modulePath):
            print(f'ERROR - invalid path to module {modulePath}')
            return
        absModule = os.path.abspath(modulePath)

        print(f'Unpacking {absModule}')
        unpackTic = time.perf_counter()
        p = subprocess.Popen([self.nwn_erf, '-f', absModule, '-x'], cwd=self.tempDir)
        p.wait()
        unpackToc = time.perf_counter()
        print(f'Unpacked module to {self.tempDir} in {unpackToc - unpackTic:0.1f}s')

        gffFiles = []
        scriptFiles = []
        for f in os.listdir(self.tempDir):
            ext = os.path.splitext(f)[1]
            if ext == '.nss':
                scriptFiles.append(f)
            elif ext != '.ncs':            
                gffFiles.append(f)

        # Greedily try to use all of the cores except for one
        p = multiprocessing.Pool(multiprocessing.cpu_count() - 1) 

        print('Converting gff files')
        convertTic = time.perf_counter()
        converter = Converter(self.nwn_gff, self.targetDir, self.tempDir)
        p.map(converter.from_gff, gffFiles)
        convertToc = time.perf_counter()
        print(f'Converted gff files in {convertToc - convertTic:0.1f}s')

        print('Copying script files')
        copyTic = time.perf_counter()
        subdir = join(self.targetDir, 'scripts')
        try:
            os.makedirs(subdir)
        except FileExistsError:
            # directory already exists
            pass
        copier = Copier(self.tempDir, subdir)
        p.map(copier.copy, scriptFiles)
        copyToc = time.perf_counter()
        print(f'Copied script files {copyToc - copyTic:0.1f}s')

    def pack(self, modulePath):
        if os.path.isfile(modulePath) or os.path.isdir(modulePath):
            print(f'ERROR - already exists {modulePath}')
            return
        absModule = os.path.abspath(modulePath)

        gffFiles = []
        scriptFiles = []
        for root, subdirs, files in os.walk(self.targetDir):
            for f in files:
                ext = os.path.splitext(f)[1]
                if ext == '.nss':
                    scriptFiles.append(f)
                elif ext != '':
                    gffFiles.append(f)

        # Greedily try to use all of the cores except for one
        p = multiprocessing.Pool(multiprocessing.cpu_count() - 1) 

        print('Compiling scripts')
        compileTic = time.perf_counter()
        compiler = Compiler(self.nwnsc, join(self.targetDir, 'scripts'), self.tempDir)
        p.map(compiler.compile, scriptFiles)
        compileToc = time.perf_counter()
        print(f'Compiled scripts in {compileToc - compileTic:0.1f}s')

        print('Converting gff files')
        convertTic = time.perf_counter()
        converter = Converter(self.nwn_gff, self.targetDir, self.tempDir)
        p.map(converter.to_gff, gffFiles)
        convertToc = time.perf_counter()
        print(f'Converted gff files in {convertToc - convertTic:0.1f}s')

        print('Copying script files')
        copyTic = time.perf_counter()
        copier = Copier(join(self.targetDir, 'scripts'), self.tempDir)
        p.map(copier.copy, scriptFiles)
        copyToc = time.perf_counter()
        print(f'Copied script files {copyToc - copyTic:0.1f}s')

        print(f'Packing {absModule}')
        packTic = time.perf_counter()
        p = subprocess.Popen([self.nwn_erf, '-e', 'MOD', '-f', modulePath, '-c', self.tempDir])
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
    def __init__(self, nwn_gff, srcDir, tempDir):
        self.nwn_gff = nwn_gff
        self.srcDir = srcDir
        self.tempDir = tempDir

    def from_gff(self, file):
        subdir = join(self.srcDir, 'resources', os.path.splitext(file)[1][1:])
        try:
            os.makedirs(subdir)
        except FileExistsError:
            # directory already exists
            pass
        outputJson = file + '.json'
        p = subprocess.Popen([self.nwn_gff, '-i', join(self.tempDir, file), '-o', join(subdir, outputJson), '-p'])
        p.wait()

    def to_gff(self, file):
        subdir = join(self.srcDir, 'resources', os.path.splitext(os.path.splitext(file)[0])[1][1:])
        outputGff = os.path.splitext(file)[0]
        p = subprocess.Popen([self.nwn_gff, '-i', join(subdir, file), '-o', join(self.tempDir, outputGff)])
        p.wait()


class Compiler:
    def __init__(self, nwnsc, srcDir, tempDir):
        self.nwnsc = nwnsc
        self.srcDir = srcDir
        self.tempDir = tempDir

    def compile(self, file):
        outfile = os.path.splitext(file)[0] + '.ncs'
        p = subprocess.Popen([self.nwnsc, '-qw', '-n', 'lib', '-r', join(self.tempDir, outfile), '-i', self.srcDir, join(self.srcDir, file)])
        p.wait()


if __name__ == "__main__":
    main()