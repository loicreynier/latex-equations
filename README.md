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
    - name: phiso
      type: package
    - name: Reyn
      type: command
      desc: Provides math mode symbol for the Reynolds number
```

requires
the usage of the `phiso` package
and the definition of the `\Reyn` command
to be integrated in a LaTeX document.

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

### Physics

#### Fluid mechanics

- [HIT one-dimensional energy spectra](/home/loic/projects/latex-equations/docs/../equations/fluidmech/hit-1d-energy-spectra.eq.tex)
- [HIT isotropy degree](/home/loic/projects/latex-equations/docs/../equations/fluidmech/hit-isotropy.eq.tex)
- [HIT Lundgren forcing term](/home/loic/projects/latex-equations/docs/../equations/fluidmech/hit-lundgren-forcing.eq.tex)
- [HIT two-point velocity correlation tensor](/home/loic/projects/latex-equations/docs/../equations/fluidmech/hit-two-point-velocity-correlation-tensor.eq.tex)
- [HIT velocity spectrum tensor](/home/loic/projects/latex-equations/docs/../equations/fluidmech/hit-velocity-spectrum-tensor.eq.tex)
- [Incompressible Navier-Stokes equations in system form](/home/loic/projects/latex-equations/docs/../equations/fluidmech/inse-sys.eq.tex)
- [Spectral density filter from POUSSINS](/home/loic/projects/latex-equations/docs/../equations/fluidmech/poussins-filter.eq.tex)
- [Ball-shaped initial density field from POUSSINS](/home/loic/projects/latex-equations/docs/../equations/fluidmech/poussins-init-rho-ball.eq.tex)
- [Momentum equation from POUSSINS](/home/loic/projects/latex-equations/docs/../equations/fluidmech/poussins-ns.eq.tex)
- [Runge-Kutta 2 scheme from POUSSINS](/home/loic/projects/latex-equations/docs/../equations/fluidmech/poussins-rk2.eq.tex)
- [Rayleigh-Taylor instability acceleration criterion](/home/loic/projects/latex-equations/docs/../equations/fluidmech/rti-criterion.eq.tex)
- [VDHIT kinetic energy evolution equation with forcing term](/home/loic/projects/latex-equations/docs/../equations/fluidmech/vdhit-kinetic-energy-with-forcing.eq.tex)
- [VDHIT Lundgren forcing term extension](/home/loic/projects/latex-equations/docs/../equations/fluidmech/vdhit-lundgren-forcing-extension-terms.eq.tex)
- [VDHIT Lundgren forcing term with production terms symbolized by a doted omega](/home/loic/projects/latex-equations/docs/../equations/fluidmech/vdhit-lundgren-forcing-omegadot-terms.eq.tex)
- [VDHIT Lundgren forcing term](/home/loic/projects/latex-equations/docs/../equations/fluidmech/vdhit-lundgren-forcing.eq.tex)
- [Dimensionless VDINSE in system form](/home/loic/projects/latex-equations/docs/../equations/fluidmech/vdinse-nd-sys.eq.tex)
- [Dimensionless VDINSE](/home/loic/projects/latex-equations/docs/../equations/fluidmech/vdinse-nd.eq.tex)
- [VDINSE in system form with Beamer alert highlight](/home/loic/projects/latex-equations/docs/../equations/fluidmech/vdinse-sys-beamer-alert.eq.tex)
- [VDINSE in system form](/home/loic/projects/latex-equations/docs/../equations/fluidmech/vdinse-sys.eq.tex)

[phiso]: https://github.com/loicreynier/phiso
