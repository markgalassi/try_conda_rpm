#! /usr/bin/env python3

import cartopy.crs as crs
import cartopy.feature as cfeature
import matplotlib.pyplot as plt
# import cartopy.crs as ccrs                   # import projections
# import cartopy.feature as cf                 # import features
# import matplotlib.plot as plt

def main():
    ax = plt.axes(projection = crs.Mercator())  # create a set of axes with Mercator projection
    ax.add_feature(cfeature.COASTLINE)                 # plot some data on them
    ax.set_title("Title")                        # label it
    # plt.show()
    plt.savefig('dude.png')
    print('saved map to file dude.png')

if __name__ == '__main__':
    main()
