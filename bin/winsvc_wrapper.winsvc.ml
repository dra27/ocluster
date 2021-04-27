let formatter =
  let f = Filename.null in
  (* let f = Filename.(concat (Sys.getenv "APPDATA") (Sys.executable_name |> basename |> remove_extension |> Fun.flip (^) ".log")) in *)
  Format.formatter_of_out_channel (open_out_bin f)

let run name main =
  let stop_notification = Lwt_unix.make_notification ~once:true (fun () -> exit 0) in
  let module Svc = Winsvc.Make
    (struct
      let name = name
      let display = ""
      let text = ""
      let arguments = []
      let stop () = Lwt_unix.send_notification stop_notification
    end)
  in
  try Svc.run main with Failure _ -> main ()

let install name display text arguments =
  let module Svc = Winsvc.Make
    (struct
      let name = name
      let display = display
      let text = text
      let arguments = arguments
      let stop () = ()
    end)
  in
  Svc.install ()

let remove name =
  let module Svc = Winsvc.Make
    (struct
      let name = name
      let display = ""
      let text = ""
      let arguments = []
      let stop () = ()
    end)
  in
  Svc.remove ()
