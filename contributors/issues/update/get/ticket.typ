#show heading: set align(center)
#show heading: set text(
  size: 20pt,
  weight: "regular",
)
#show heading: smallcaps

#heading[
  Contributors: Issues::Update::GET#super[#link("https://github.com/sh1chan/contributors/")[\u{2197}]]
]

#grid(
  columns: (1fr),
  align(center)[
    YóUnǎi \u{22B7} ames0k0 \
    E-Mail#super[#link("mailto:uuid.ames0k0@gmail.com")[\u{2197}]]
    LinkedIn#super[#link("https://www.linkedin.com/in/ames0k0/")[\u{2197}]]
    Github#super[#link("https://github.com/ames0k0/")[\u{2197}]]
  ]
)

#align(center)[
  #set par(justify: false)
  *Abstract* \
Contributors is a web application designed to streamline open-source contribution by improving how developers discover and share coding tasks. Built to address the limitations of issue discovery on code hosting platforms with integrated issue trackers, it enables users to curate, tag, and submit contribution-friendly issues—helping developers quickly find clear, actionable opportunities to collaborate when they’re ready to contribute. \
Tech Stack: _Python_, _FastAPI_, _MongoDB_
#align(center, image("./Diagram.drawio.svg"))
]

= Ticket
#align(center, image("./Diagram-Update-GET.drawio.svg"))

= Request
```
+! P.issue_id
|> str.Strip
|> orelse raise ValidationError
```

= Controller
```
+! C.access_token
|> orelse raise InvalidTokenError

+! D.current_user
|> orelse raise InvalidTokenError

+! D.c_issues

+! P.issue_id
|> db.FindOne(issues.id)
|> orelse redirect RedirectResponse(NotFoundErrMsg)
|> permissions.IsOwner(current_user.id, issues.created_by)
|> orelse redirect RedirectResponse(PermissionsErrMsg)

+! return TemplateResponse(current_user, issue).RenderForm()
```
