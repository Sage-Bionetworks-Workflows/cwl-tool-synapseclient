This example takes text from a command line standard output (`stdout`) and parses lines into an array of strings.

The steps are combined in a workflow, `ls2array.cwl` which runs `ls.cwl` followed by `stdout2array.cwl`. The output for a workflow run with the command

```
cwltool ls2array.cwl ls.json
```

...where the job JSON specifies the current directory as input `folder`

```json
{
    "folder": {
        "class": "Directory",
        "path": "."
    }
}
```

<details>

<summary>...looks like this:</summary>

```
/Users/jaeddy/anaconda/envs/translator/bin/cwltool 1.0.20190228155703
Resolved 'ls2array.cwl' to 'file:///Users/jaeddy/code/github/projects/synapse-client-cwl-tools/str_to_array_example/ls2array.cwl'
[workflow ] start
[workflow ] starting step list_files
[step list_files] start
[job list_files] /private/tmp/docker_tmplgqcgklh$ ls \
    /private/var/folders/xt/2mpzwr2972g3_yqgjz5dbsg40000gq/T/tmp6cx6g7wu/stg0cbe0d12-714b-480f-ad29-654acc8f88ae/str_to_array_example > /private/tmp/docker_tmplgqcgklh/message
Could not collect memory usage, job ended before monitoring began.
[job list_files] completed success
[step list_files] completed success
[workflow ] starting step parse_stdout
[step parse_stdout] start
[job parse_stdout] /private/tmp/docker_tmpfz53gzwz$ echo \
    /private/var/folders/xt/2mpzwr2972g3_yqgjz5dbsg40000gq/T/tmpps3_p9ov/stga3f425e5-f3b9-4f83-b294-a33ea6c028b9/message > /private/tmp/docker_tmpfz53gzwz/message
Could not collect memory usage, job ended before monitoring began.
[job parse_stdout] completed success
[step parse_stdout] completed success
[workflow ] completed success
{
    "ls_lines": [
        "README.md",
        "ls.cwl",
        "ls.json",
        "ls2array.cwl",
        "stdout2array.cwl",
        ""
    ]
}
Final process status is success
```

</details>

### Lesson

The trick for getting this to work in a workflow seems to be the combination of parsing text using in-line JavaScript but also using `echo` to make sure `stdout` can be captured. The JavaScript only approach (i.e., using an `ExpressionTool`) seems to work fine as a stand-alone tool, but fails when ran as part of the workflow. By capturing `stdout`, CWL creates a file-like path that the runner is able to interpret and reason about (at least... that's my understanding).

Comments and improvements welcome!

### Notes

The expression

```cwl
$(inputs.stdout_text.contents.split('\n'))
```

... obviously only works if you want all lines from the `stdout` message. For more control of which lines are captured, you can use a larger expression to iterate over and check lines for specific conditions:

```cwl
outputs:
- id: stdout_lines
  type:
    type: array
    items: string  
  outputBinding:
    glob: message
    loadContents: true
    outputEval: |
      ${
        var lines = inputs.stdout_text.contents.split('\n');
        var newlines = [];
        var i = 0;
        for (var i=0; i<lines.length; i++) {
          if (lines[i] !== "message") {
            newlines.push(lines[i]);
          }
        }
        return newlines;
      }
```

The above snippet would only return the names of files that aren't named "message" (credit to @sgosline for the example. The more JS you know, the more control you can have!

