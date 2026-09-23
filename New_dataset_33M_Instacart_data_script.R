library(tidyverse)
library(readr)
data_raw<- read_csv(file.choose())
data_raw
glimpse(data_raw)
final_33M_data<- data_raw %>%  distinct() %>%
  mutate(
    order_id = as.integer(order_id),
    product_id = as.integer(product_id),
    add_to_cart_order = as.integer(add_to_cart_order),
    reordered = as.integer(reordered)
  ) %>% filter(order_id > 5 & product_id > 30000 &
                 add_to_cart_order > 5 & reordered >= 0 ) %>%
  select(order_id,product_id,add_to_cart_order,reordered)
final_33M_data
write.csv(final_33M_data,'New_dataset_33M_Instacart_data.csv',
          row.names = FALSE)
getwd()
