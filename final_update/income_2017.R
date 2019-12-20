read_income <- function(path) {
  read_rds(path) %>% 
    select(-variable, -moe) %>% 
    rename(median_income = estimate)
}


de_income <- read_income("export_2017/de_income.rds")
fl_income <- read_income("export_2017/fl_income.rds")
md_income <- read_income("export_2017/md_income.rds")
me_income <- read_income("export_2017/me_income.rds")
mt_income <- read_income("export_2017/mt_income.rds")
nc_income <- read_income("export_2017/nc_income.rds")
nh_income <- read_income("export_2017/nh_income.rds")
nv_income <- read_income("export_2017/nv_income.rds")
vt_income <- read_income("export_2017/vt_income.rds")
wv_income <- read_income("export_2017/wv_income.rds")




join <- function(school_district_shape, state_diversity) {
  school_district_shape %>% 
    left_join(state_diversity, by = c("GEOID" = "leaid")) %>% 
    st_transform(2163) %>% 
    mutate_at(vars(aian:multi), ~ scales::percent(round(.x, 1), scale = 1))
}



# most diverse 5
de <- read_rds("export_2017/de_school_district_shape.rds") %>% 
  join(diversity_2017 %>% 
         filter(st == "DE")) %>%
  select(st, GEOID, lea_name, DI, diverse, total, aian:multi) %>% 
  left_join(de_income) %>% 
  select(-NAME)

fl <- read_rds("export_2017/fl_school_district_shape.rds") %>% 
  join(diversity_2017 %>% 
         filter(st == "FL")) %>% 
  select(st, GEOID, lea_name, DI, diverse, total, aian:multi) %>% 
  left_join(fl_income) %>% 
  select(-NAME)

md <- read_rds("export_2017/md_school_district_shape.rds") %>% 
  join(diversity_2017 %>% 
         filter(st == "MD")) %>% 
  select(st, GEOID, lea_name, DI, diverse, total, aian:multi) %>% 
  left_join(md_income) %>% 
  select(-NAME)

nc <- read_rds("export_2017/nc_school_district_shape.rds") %>% 
  join(diversity_2017 %>% 
         filter(st == "NC")) %>% 
  select(st, GEOID, lea_name, DI, diverse, total, aian:multi) %>% 
  left_join(nc_income) %>% 
  select(-NAME)

nv <- read_rds("export_2017/nv_school_district_shape.rds") %>% 
  join(diversity_2017 %>% 
         filter(st == "NV")) %>% 
  select(st, GEOID, lea_name, DI, diverse, total, aian:multi) %>% 
  left_join(nv_income) %>% 
  select(-NAME)

# least diverse 5

me <- read_rds("export_2017/me_school_district_shape.rds") %>% 
  join(diversity_2017 %>% 
         filter(st == "ME")) %>% 
  select(st, GEOID, lea_name, DI, diverse, total, aian:multi) %>% 
  left_join(me_income) %>% 
  select(-NAME)

mt <- read_rds("export_2017/mt_school_district_shape.rds") %>% 
  join(diversity_2017 %>% 
         filter(st == "MT")) %>% 
  select(st, GEOID, lea_name, DI, diverse, total, aian:multi) %>% 
  left_join(mt_income) %>% 
  select(-NAME)

nh <- read_rds("export_2017/nh_school_district_shape.rds") %>% 
  join(diversity_2017 %>% 
         filter(st == "NH")) %>% 
  select(st, GEOID, lea_name, DI, diverse, total, aian:multi) %>% 
  left_join(nh_income) %>% 
  select(-NAME)

vt <- read_rds("export_2017/vt_school_district_shape.rds") %>% 
  join(diversity_2017 %>% 
         filter(st == "VT")) %>% 
  select(st, GEOID, lea_name, DI, diverse, total, aian:multi) %>% 
  left_join(vt_income) %>% 
  select(-NAME)

wv <- read_rds("export_2017/wv_school_district_shape.rds") %>% 
  join(diversity_2017 %>% 
         filter(st == "WV")) %>% 
  select(st, GEOID, lea_name, DI, diverse, total, aian:multi) %>% 
  left_join(wv_income) %>% 
  select(-NAME)




diversity_income_2017 <- rbind(
  de, 
  fl,
  md, 
  nc,
  nv,
  me,
  mt,
  nh,
  vt,
  wv
) 
