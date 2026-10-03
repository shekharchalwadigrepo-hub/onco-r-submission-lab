# Teaching template — write an ADaM dataset to SAS v5 transport.
# FDA study data are still expected as XPT unless a catalog entry or
# agreement says Dataset-JSON is acceptable for that submission.

# library(xportr)
# library(metacore)

# spec <- spec_to_metacore("metadata/adam_spec.xlsx") |>
#   select_dataset("ADTTE")

# adtte_xpt <- adtte |>
#   xportr_type(spec, domain = "ADTTE") |>
#   xportr_length(spec, domain = "ADTTE") |>
#   xportr_label(spec, domain = "ADTTE") |>
#   xportr_order(spec, domain = "ADTTE") |>
#   xportr_format(spec, domain = "ADTTE")

# xportr_write(
#   adtte_xpt,
#   path = "m5/datasets/ABC123/analysis/adam/datasets/adtte.xpt",
#   domain = "ADTTE"
# )

# Dataset-JSON (Pilot 5 direction), only when the submission is supposed to use it:
# datasetjson::dataset_json(adtte, file = "adtte.json")

message("Template only. Run xportr checks before the publishing handoff.")
