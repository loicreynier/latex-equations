# LaTeX equations

Collection of diverse equations written in LaTeX
that I import and reuse in different documents.

## Quickstart

0. Add the repository as a submodule of the document repository

   ```shell
   cd project
   git submodule add https://github.com/loicreynier/equations .gitmodules/equations
   ln -s .gitmodules/equations/equations equations
   ```

1. Import an equation into a LaTeX document

   ```latex
   \input{equations/<category>/<equation-label>.tex}
   ```

   or in a Markdown document
   with the [`include-files`][include_files_filter] Pandoc filter

   ````markdown
   ```{.include}
   equations/<equation-label>.tex
   ```
   ````

2. Reference the equation in a LaTeX document

   ```latex
   ... equation~\eqref{eq:<equation-label>}
   ```

   or in a Markdown document
   with the [`pandoc-xnos`][pandoc_xnos] filter

   ```markdown
   ... equation @eq:<equation-label>
   ```

[include_files_filter]: https://github.com/pandoc/lua-filters/tree/master/include-files
[pandoc_xnos]: https://github.com/tomduck/pandoc-xnos

## Requirements

All the equations require my personal [`phiso` package][phiso]
which provides commands for typesetting equations
according to the ISO-80000 standards.
Any package providing the same commands can be used instead.

## Metadata files

Each equation file `<equation-label>.tex` is associated with
a `<equation-label>.tex.meta.yaml` YAML metadata file
containing the equation description
and the packages necessary for its use in a LaTeX document.

As an example, an equation with the following metadata file

```yaml
file: <equation-label>.tex
title: Random equation
info:
  requirements:
    - name: beamer
      type: package
    - name: Reyn
      type: command
      desc: Provides math mode symbol for the Reynolds number
```

requires
the usage of the `beamer` package
and the definition of the `\Reyn` command
to be integrated in a LaTeX document.
`phiso` requirements are omitted.

Each equation is labeled `eq:<equation-label>` where `<equation-label>`
is the equation file name (omitting the `.tex` extension.)
Some equation files contain multiple equations
stacked in a `subequations` environment.
In that case,
the main label `eq:<equation-label>` links to the `subequations` environment
and additional sublabels of the form `eq:<equation-label>_sublabel`
are added for each subequation.
Those sublabels are documented in the `info` section of the metadata file.

## Equations

{{equation_list}}

[phiso]: https://github.com/loicreynier/phiso
