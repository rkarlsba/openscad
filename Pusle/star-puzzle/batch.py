#!/usr/bin/python3

import subprocess
import sys

processes = [
    subprocess.Popen(
        [
            'openscad',
            '-D',
            f'i={i}',
            '-o',
            f'dist/star-puzzle-piece-{i}.stl',
            'parallel.scad'
        ],
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE
    )
    for i in range(6)
]

print('Running...')

for process in processes:
    _, err = process.communicate()
    if err:
        print(err)
        continue
    sys.stdout.write('.')
    sys.stdout.flush()

sys.stdout.write('\n')
print('Done!')
