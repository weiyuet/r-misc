library(gt)
library(tidyverse)
library(palmerpenguins)

penguins %>%
  group_by(species) %>%
  summarise(across(bill_length_mm:body_mass_g, mean, na.rm = TRUE)) %>%
  gt(rowname_col = "species") %>%
  tab_header(
    title = md("Summary of the `Penguins` Data Set"),
    subtitle = md("Uses **Three** years of data from *three* islands")
  ) %>%
  cols_label(
    bill_length_mm = md("Bill Length,<br>mm"),
    bill_depth_mm = md("Bill Depth,<br>mm"),
    flipper_length_mm = md("Flipper Length,<br>mm"),
    body_mass_g = md("Body Mass,<br>kg")
  ) %>%
  tab_stubhead(label = md("`Penguin Species`")) %>%
  opt_align_table_header(align = "left") %>%
  fmt_number(columns = bill_length_mm:flipper_length_mm) %>%
  fmt_number(columns = body_mass_g, scale_by = 0.001) %>%
  cols_width(bill_length_mm:body_mass_g ~ px(120)) %>%
  tab_source_note(source_note = md("Data set is from the `palmerpenguins` **R** package")) %>%
  tab_footnote(
    footnote = "The largest of the three penguins studied.",
    locations = cells_stub(rows = "Gentoo")
  )
