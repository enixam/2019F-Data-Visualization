library(scales)
library(hrbrthemes)
library(viridis)


tern_data <- raw_data %>% 
  select(
    st,
    year,
    diverse,
    total
  ) %>%
  mutate(year = str_extract(year, "\\d{4}$"))

prop_by_state <- tern_data %>% 
  group_by(st, year, diverse) %>% 
  summarise(total = total %>% sum(na.rm = TRUE)) %>% 
  ungroup() %>% 
  group_by(st, year) %>% 
  mutate(prop = prop.table(total)) %>% 
  ungroup() %>% 
  select(-total) %>%
  pivot_wider(names_from = diverse,
              values_from = prop) %>%
  replace_na(list(Diverse = 0, `Extremely undiverse` = 0, Undiverse = 0))


total_student_by_state <- tern_data %>%
  group_by(st, year) %>% 
  summarize(total = sum(total, na.rm = T)) %>% 
  ungroup()
  

library(ggtern)
ggtern_plot <- prop_by_state %>% 
  left_join(total_student_by_state) %>% 
  group_by(year) %>% 
  arrange(desc(total)) %>%
  ggtern::ggtern(aes(`Extremely undiverse`, Undiverse, z = Diverse, group = st)) +
  geom_text(
    aes(label = st, size = total, color = total, alpha = total), 
    family = "Cinzel", fontface = 2
  ) + 
  facet_wrap(~ year) + 
  scale_size_continuous(range = c(1, 10)) +
  scale_alpha_continuous(range = c(.7, 1), trans = "reverse") + 
  scale_color_viridis(
    option = "A",
    limits = c(0, 6e6), 
    breaks = 1:5 * 1e6,
    labels = label_number_si()
  ) + 
  ggtern::scale_L_continuous("Ex Undiverse") + 
  guides(
    size = FALSE,
    alpha = FALSE,
    color = guide_colorbar(
      barwidth = 20, 
      barheight = 0.5,
      title.position = "top")) +  
  labs(
    title = "Proportions of students in 3 categories of schools",
    color = "# of students",
    caption = "Source: NCES & Washington Post") + 
  theme_gray(base_family = "Cinzel", base_size = 14) + 
  ggtern::theme(
    legend.position = "bottom",
    axis.title = element_blank(),
    panel.border = element_rect(color = NA, fill = NA),
    strip.background = element_rect(fill = "grey90",
                                    color = NA),
    strip.text = element_text(colour = "#70284a", face = 2, size = 20),
    plot.background = element_rect(fill = NA, color = NA),
    tern.axis.arrow.show = TRUE,
    tern.axis.title = element_text(family = "Cinzel", face = 2),
    tern.axis.title.R = element_text(hjust = 1.5, vjust = 3),
    tern.axis.title.L = element_text(vjust = 2),
    tern.axis.ticks.length.major = unit(12, "pt"),
    plot.title = element_text(size = 26, family = "Cinzel"),
    plot.subtitle = element_text(size = 20),
    plot.caption  = element_text(size = 12)) 

