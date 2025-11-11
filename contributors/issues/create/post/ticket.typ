#show heading: set align(center)
#show heading: set text(
  size: 20pt,
  weight: "regular",
)
#show heading: smallcaps

#heading[
  Contributors: Issues::Create::POST#super[#link("https://github.com/sh1chan/contributors/")[\u{2197}]]
]

#grid(
  columns: (1fr),
  align(center)[
    YóUnǎi \u{22B7} ames0k0 \
    EMail#super[#link("mailto:uuid.ames0k0@gmail.com")[\u{2197}]]
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
#align(center, image("./Diagram-Create.drawio.svg"))

1. `Request`
2. Form Validation
3. Data Validation
4. Data Insertion
5. `Response`

= 1. Request
```
+! CurrentUser
|> cookies[AccessToken]
```

= 2. Form Validation
```
+? F.url        +! F.title        +? F.description  +! F.tags         +? F.labels
|> str.Strip    |> str.Strip      |> str.Strip      |> str.Strip      |> str.Strip
|> SupportedURL |> orelse raise                     |> str.Split[,]   |> str.Split[,]
|> orelse raise                                     |> orelse raise
```

= 3. Data Validation
```
+? F.url
|> db.exists(issues.url)
|> raise
```

= 4. Data Insertion
```
+! F.@ + CurrentUser
|> db.insert(issues)

+! F.tags
|> db.exists(categories.identifier && categories.name)
|> db.update(categories.issues_ids)
|> orelse db.insert(categories)

+? F.labels
|> db.exists(categories.identifier && categories.name)
|> db.update(categories.issues_ids)
|> orelse db.insert(categories)
```

= 5. Response
```
+? Error                          +? Success
|> entryPoint(/issues/create/)    |> entryPoint(/issues/)
|> error_message                  |> error_message
```
