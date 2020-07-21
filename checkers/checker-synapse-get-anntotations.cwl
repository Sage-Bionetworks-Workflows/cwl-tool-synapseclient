cwlVersion: v1.0
class: Workflow

requirements:
  - class: SubworkflowFeatureRequirement

$namespaces:
  dct: http://purl.org/dc/terms/
  foaf: http://xmlns.com/foaf/0.1/

dct:creator:
  '@id': https://orcid.org/0000-0002-5841-0198
  foaf:name: Thomas Yu
  foaf:mbox: mailto:thomas.yu@sagebionetworks.org

inputs:
  synapse_config: File
  synapseid: string
  expected_md5: string

outputs:
  workflow_output_file:
    type: File
    outputSource: checker/workflow_output_file

steps:
  get_annotations:
    run: ../cwl/synapse-get-annotations-tool.cwl
    in:
      synapse_config: synapse_config
      synapseid: synapseid
    out: [annotations_file, annotations_text]
  checker:
    run: https://raw.githubusercontent.com/dockstore-testing/md5sum-checker/1.0.1/checker-workflow-wrapping-workflow.cwl
    in:
      input_file: get_annotations/annotations_file
      expected_md5: expected_md5
    out: [workflow_output_file]

doc: |
  This demonstrates how to wrap a "real" tool with a checker workflow that runs both the tool and a tool that performs verification of results