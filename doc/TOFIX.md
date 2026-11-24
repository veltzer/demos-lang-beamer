# TOFIX

Findings from a code scan on 2026-10-04.

## Medium

- `rsconstruct.toml:1` - the repo's only real content, `src/c_preprocessor.tex`, is not built or checked by any processor, so a LaTeX error in it never fails CI. Add `[processor.pdflatex]` with `src_dirs = ["src"]` (the default `shell_escape = true` is required by `\usepackage{minted}` at `src/c_preprocessor.tex:16`, and minted also needs pygments available to the build).

## Low

- `src/c_preprocessor.tex:46` - the deck is titled "C preprocessor / advanced tips and tricks" but the frames at lines 75-115 are generic placeholders ("Slide1", a hello-world `lstlisting` and a Python `minted` sample) with no preprocessor content. Either write the preprocessor slides or retitle the file as a beamer feature demo (e.g. `beamer_listings.tex`).
- `src/c_preprocessor.tex:11` - commented-out dead alternatives (lines 11-12, 17, 69-72, 87-93) clutter the demo; drop them or turn the useful ones into a short comment explaining the option.
