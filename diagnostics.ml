type severity =
  | Info
  | Warning
  | Error

type diagnostic = {
  severity  : severity;
  location  : Camlp4.PreCast.Loc.t;
  message   : string;
}


let string_of_severity terminal =
  let module T = (val terminal : TermColour.S) in
  let module Colour = TermColour.Make(T) in

  let open Colour in function
  | Info    -> cyan   "Info"
  | Warning -> yellow "Warning"
  | Error   -> red    "Error"


let string_of_severity =
  if Unix.(isatty stdout) then
    string_of_severity (module TermColour.ANSI : TermColour.S)
  else
    string_of_severity (module TermColour.None : TermColour.S)


exception Exit

let diagnostics = BatDynArray.create ()

let diagnostic severity at =
  let location = fst (Sloc._loc at) in
  (* Let the client code do the actual formatting. *)
  Format.ksprintf (fun message ->
    (* Add the diagnostic to the list. *)
    BatDynArray.add diagnostics {
      severity;
      location;
      message;
    }
  )

let info    at = diagnostic Info    at
let warning at = diagnostic Warning at
let error   at = diagnostic Error   at


let exit_on_error () =
  try
    ignore (BatDynArray.index_of (fun { severity } -> severity == Error) diagnostics);
    raise Exit
  with Not_found ->
    ()


let print () =
  BatDynArray.iter (fun { severity; location; message } ->
    (* show diagnostic on stdout *)
    Printf.printf "%s:\n%s: %s\n"
      (Camlp4.PreCast.Loc.to_string location)
      (string_of_severity severity)
      message
  ) diagnostics
