install Library ".DEFAULT" [
  (* Target *)
  Name		"codegen";
  Description	"Code generation helpers";

  (* Sources *)
  Modules [
    "CamlAst";
    "Classify";
    "Diagnostics";
    "LocStringMap";
    "Sloc";
    "SlocMap";
  ];

  (* Library dependencies *)
  OCamlRequires [
    "corelib";
    "camlp4.quotations";
    "camlp4.fulllib";
    "sexplib.syntax";
  ];

  OCamlIncludes [
    "+camlp4/Camlp4Parsers";
  ];

  (* Camlp4 *)
  Flags [
    "camlAst.ml",	"-syntax camlp4o";
    "sloc.ml",		"-syntax camlp4o";
  ];
]
