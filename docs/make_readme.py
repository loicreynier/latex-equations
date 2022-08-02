#!/usr/bin/env python3

"""
Script to generate the `README.md`

Equation metadata `.meta.yaml` files are parsed and
added in the last section of the Markdown template.
"""

__author__ = ["Loïc Reynier <loic@loicreynier.fr>"]
__version__ = "0.1.0"

import os
import sys

import jinja2
import yaml


def equations_dict(dir_path: str, metadata_ext: str) -> str:
    """Dictionnary containing equation files ordened in categories
    generated from the `metadata_ext` files in `dir_path`.
    """
    dict_ = {}
    for subdir_path, _, file_list in sorted(os.walk(dir_path)):
        for file_name in sorted(file_list):
            if file_name.endswith(metadata_ext):
                file_path = subdir_path + os.sep + file_name
                with open(file_path, "r", encoding="utf-8") as file:
                    meta = yaml.load(file, Loader=yaml.CLoader)
                    key = meta["info"]["category"]
                val = [(subdir_path + os.sep + meta["file"], meta["title"])]
                try:
                    dict_[key] += val
                except KeyError:
                    dict_[key] = val
    return dict_


def equation_list(
    dir_path: str,
    metadata_ext: str,
    header_level: int,
) -> str:
    """Markdown list of the form `{file}: {description}` generated from
    the `metadata_ext` files in `dir_path`.
    """
    list_ = ""
    dict_ = equations_dict(dir_path, metadata_ext)
    for category, equations in dict_.items():
        list_ += (
            "#" * (header_level)
            + " "
            + category.split("/")[0]
            + "\n\n"
            + "#" * (header_level + 1)
            + " "
            + category.split("/")[1]
            + "\n\n"
        )
        for equation in equations:
            list_ += f"- [{equation[1]}]({equation[0]})\n"
    return list_[:-1]


def make_readme() -> None:
    """Make `README.md` from `template.md`."""
    jinja_env = jinja2.Environment(
        loader=jinja2.FileSystemLoader(searchpath="./"),
        keep_trailing_newline=True,
    )

    list_ = equation_list(
        os.getcwd() + os.path.sep + "../equations",
        ".meta.yaml",
        3,
    )

    template = jinja_env.get_template("template.md")
    with open("../README.md", "w", encoding="utf-8") as readme_file:
        readme_file.write(template.render(equation_list=list_))


if __name__ == "__main__":
    os.chdir(sys.path[0])
    # print(os.path.basename(__file__) + ": running in " + os.getcwd())
    make_readme()
