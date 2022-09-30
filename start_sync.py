"""Manage sync with cloud providers."""

import argparse
import logging
import os
import subprocess
import sys
import time
from typing import Any, Set

logging.basicConfig(level=logging.DEBUG, format="%(message)s")


def main(sys_argv):
    parser = argparse.ArgumentParser(
        description="Manage sync with cloud providers.")
    parser.add_argument("-d", "--rclone_dest", type=str,
                        help="Rclone address destination. " +
                        "Example: `remote-mega:/some_dir`")
    parser.add_argument("-s", "--motion_source", type=str,
                        default="/motion/",
                        help="Motion file source.")
    parser.add_argument("-m", "--mocam_config", type=str,
                        default="/mocam/rclone.conf",
                        help="Rclone config file.  " +
                        "By default: /mocam/rclone.conf")

    args = parser.parse_args(sys_argv[1:])

    motion_source_path: str = os.path.abspath(args.motion_source)

    # Create directory for Motion to put images and videos
    try:
        os.mkdir(motion_source_path)
    except FileExistsError as fe:
        logging.warning(fe)

    prev_state: Set = _get_file_state(motion_source_path)

    while True:
        current_state: Set = _get_file_state(motion_source_path)
        logging.debug("CURRENT FILES: %s", current_state)

        if prev_state != current_state:
            logging.info("File change detected")
            subprocess.call([
                "rclone", "move",
                f"{args.motion_source}",
                f"{args.rclone_dest}",
                "--progress",
                f"--config={args.mocam_config}"], shell=False)

        prev_state = current_state
        time.sleep(5)  # Seconds
        logging.info("Sleeping...")


def _get_file_state(path: str) -> Any:
    """Returns number of files in directory."""
    content_list = set()
    for _, dir_list, file_list in os.walk(path):
        for item in dir_list:
            content_list.add(item)

        for item in file_list:
            content_list.add(item)

    return content_list


if __name__ == "__main__":
    main(sys.argv)
