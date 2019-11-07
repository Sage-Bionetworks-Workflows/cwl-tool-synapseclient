#!/usr/bin/env python3
'''
Take a list of metadata values, a list of files, and a csv file and matches the values based on a provided key column in the csv file.

'''

import pandas
import sys
import argparse
import os


if __name__ == '__main__':

    parser = argparse.ArgumentParser("Merges list of values with other data from a csv file and returns new csv file.")

    parser.add_argument(
            '-m',
            '--manifest_file',
            type = str,
            required=True)

    parser.add_argument(
            '-f',
            '--filelist',
            type = str,
            nargs='+',
            required=True)

    parser.add_argument(
        '-p',
        '--parentId',
        type= str,
        required=True)

    parser.add_argument(
        '-v',
        '--values',
        type=str,
        nargs='+',
        required=True,
        help='List of values by which you would like to join')

    parser.add_argument(
        '-k',
        '--key',
        type=str,
        default='specimenID',
        help='Key on which you want to join')

    parser.add_argument(
        '-u',
        '--used',
        type=str,
        nargs='+',
        required=False,
        help='List of synapse ids used in this analysis')

    parser.add_argument(
        '-e',
        '--executed',
        type=str,
        nargs='+',
        required=False,
        help='List of files used to execute this')

    args = parser.parse_args()

    if(len(args.values)!=len(args.filelist)):
        print('keys and list of files need to be the same length')

    #read in manifest
    manifest=pandas.read_csv(args.manifest_file,sep='\t')
    manifest=manifest.drop(["ROW_ID","ROW_VERSION","ROW_ETAG"],axis=1)

    #join specimens and synids into data frame
    specToSyn=pandas.DataFrame({args.key:args.values,'path': [os.path.basename(a) for a in args.filelist]})


    #add in parent id
    specToSyn['parent'] = args.parentId

    ##add in provenance
   # if args.used is not None:
   #     specToSyn['used']=args.used.join(',') ##what is the delimiter?
   # if args.executed is not None:
   #     specToSyn['executed']=args.executed.join(',')

    #join entire dataframe
    full_df=specToSyn.merge(manifest, on=args.key)

    full_df.to_csv(sys.stdout,sep='\t',index=False)
