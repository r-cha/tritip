(lang dune 3.12)

(name tritip)

(generate_opam_files true)

(source
 (github r-cha/tritip))

(authors "Robert Chandler")

(maintainers "Robert Chandler")

(license LICENSE)

(package
 (name tritip)
 (synopsis "Try typing in your terminal")
 (description "A CLI tool to practice typing using any file.")
 (depends ocaml dune)
 (tags
  ("cli" "tui" "typing")))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
