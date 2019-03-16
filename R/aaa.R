httr::user_agent(
  sprintf(
    "packettotal package v%s: (<%s>)",
    utils::packageVersion("packettotal"),
    utils::packageDescription("packettotal")$URL
  )
) -> .PACKETTOTAL_UA
