install Library ".DEFAULT" [
  (* Target *)
  Name		"codegen";
  Description	"Code generation helpers";
  Version	"0.1";

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
    "baselib";
    "camlp4.quotations";
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
