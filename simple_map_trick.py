#! /usr/bin/env python3

import sys
try:
    import cartopy.crs as crs
    import cartopy.feature as cfeature
    import matplotlib.pyplot as plt
except:
    print('**error** -- could not import cartopy and/or matplotlib')
    print('you should be able to run:')
    wrapper_command_line = sys.argv[0].replace('.py', '_wrap')
    if len(sys.argv) > 1:
        wrapper_command_line += ' '
    wrapper_command_line += ' '.join(sys.argv[1:])
    print(f'{wrapper_command_line}')
    sys.exit(1)

def main():
    ax = plt.axes(projection = crs.Mercator())  # create a set of axes with Mercator projection
    ax.add_feature(cfeature.COASTLINE)                 # plot some data on them
    ax.set_title("Title")                        # label it
    # plt.show()
    plt.savefig('dude.png')
    print('saved map to file dude.png')

if __name__ == '__main__':
    main()
