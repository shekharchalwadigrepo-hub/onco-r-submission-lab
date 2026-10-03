# Teaching template — objective response table and a KM curve from ADTTE.
# Displays should read ADaM, not SDTM.

# library(dplyr)
# library(gt)

# orr <- adsl |>
#   filter(ITTFL == "Y") |>
#   count(TRT01P, RESPFL, name = "n") |>
#   group_by(TRT01P) |>
#   mutate(N = sum(n), pct = round(100 * n / N, 1))

# orr_responders <- orr |>
#   filter(RESPFL == "Y") |>
#   gt() |>
#   tab_header(
#     title = "Confirmed objective response",
#     subtitle = "Intent-to-treat set. Teaching shell, not a CSR table."
#   )

# gtsave(orr_responders, "tlf/t-orr.html")

# KM (survival + ggsurvfit) uses ADTTE where PARAMCD == "PFS":
#   AVAL is the analysis duration, CNSR == 0 is the event.
# State the unit (days or months) in both the program and the ADRG.

message("Template only. Table shells belong in the SAP mock, not in ad-hoc code.")
