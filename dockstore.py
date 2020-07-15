"""Read in test descriptions and publish dockstore tools"""
import argparse
import os
import subprocess

import yaml


def main(yaml_path, tag, dockerrepo, giturl):
    """Publish dockstore tools

    Args:
        yaml_path: Path to test descriptions
        tag: github tag or branch
        dockerrepo: Docker repository
                    (e.g. sagebionetworks/synapsepythonclient)
        giturl: Link to github URL
                (e.g. git@github.com:....git)

    """
    print(tag)
    with open(yaml_path, 'r') as yaml_f:
        tools = yaml.load(yaml_f, Loader=yaml.FullLoader)

    docker_info = dockerrepo.split("/")
    docker_namespace = docker_info[0]
    docker_name = docker_info[1]
    for tool in tools:
        print(tool['tool'])
        cwlname = os.path.basename(tool['tool'])
        testname = tool['job']
        toolname = cwlname.replace(".cwl", "").replace("-tool", "")

        # This command is to publish any dockstore tool that doesn't exist yet
        dockstore_cmd = [
            'dockstore', 'tool', 'manual_publish',
            '--namespace', docker_namespace,
            '--name', docker_name,
            '--git-url', giturl,
            '--git-reference', tag,
            '--cwl-path', os.path.join('/cwl', cwlname),
            '--wdl-path', '',
            '--test-cwl-path', os.path.join('/tests', testname),
            '--test-wdl-path', '',
            '--toolname', toolname,
        ]
        # If the tool already exists, then just update the version
        update_version_cmd = [
            'dockstore', 'tool', 'version_tag', 'add',
            '--entry',
            f'registry.hub.docker.com/{docker_namespace}/{docker_name}/{toolname}',
            '--name', tag,
            '--git-reference', tag,
            '--image-id', dockerrepo
        ]
        # Publishing tool will fail if tool already exists
        try:
            subprocess.check_call(dockstore_cmd)
            return
        except Exception:
            print("Tool already exists")
            pass

        # Updating version tag will fail if tag already exists
        try:
            subprocess.check_call(update_version_cmd)
        except Exception:
            print("Tag already exists")
            pass


def cli():
    """Dockstore publisher cli"""
    parser = argparse.ArgumentParser(description='Launch dockstore tools')
    parser.add_argument("yaml_path", help='Path to test descriptions')
    parser.add_argument("tag", help="Github tag or branch")
    parser.add_argument("dockerrepo", help="Docker repository")
    parser.add_argument("giturl", help="Link to github URL")
    return parser.parse_args()


if __name__ == "__main__":
    args = cli()
    main(args.yaml_path, args.tag, args.dockerrepo, args.giturl)
