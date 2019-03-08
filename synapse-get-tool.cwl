#!/usr/bin/env cwl-runner
#

cwlVersion: v1.0
class: CommandLineTool
baseCommand: python

inputs:
  - id: synapse_config
    type: File
  - id: synapseid
    type: string

arguments:
  - valueFrom: download_synapse_file.py
  - valueFrom: $(inputs.synapseid)
    prefix: -s
  - valueFrom: $(inputs.synapse_config.path)
    prefix: -c

requirements:
  - class: InlineJavascriptRequirement
  - class: InitialWorkDirRequirement
    listing:
      - entryname: download_synapse_file.py
        entry: |
          #!/usr/bin/env python
          import synapseclient
          import argparse
          import os
          parser = argparse.ArgumentParser()
          parser.add_argument("-s", "--synapseid", required=True, help="Submission Id")
          parser.add_argument("-c", "--synapse_config", required=True, help="Credentials file")
          args = parser.parse_args()
          syn = synapseclient.Synapse(configPath=args.synapse_config)
          syn.login()
          sub = syn.get(args.synapseid, downloadLocation=".")
          print(sub.path)
     
outputs:
  - id: filepath
    type: File
