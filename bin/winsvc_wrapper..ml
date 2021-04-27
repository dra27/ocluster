let formatter = Format.err_formatter

let run _name main = main ()

let install _name _display _text _arguments = Logs.err (fun f -> f "Cannot install a service on non-Windows systems.")

let remove _name = Logs.err (fun f -> f "Cannot remove a service on non-Windows systems.")
