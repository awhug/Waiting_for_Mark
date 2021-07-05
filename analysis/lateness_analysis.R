library(here)
library(survival)
library(survminer)
library(patchwork)
library(lubridate)

# Import data
all_data <- readRDS(here("Waiting_for_Mark/data/mmg_times.rds"))

# Remove unverified late time outlier
all_data <- all_data[-24, ]

# Calculate median lateness time
median(all_data$diff)

# Calculate median absolute deviation
mad(all_data$diff)

# Plot histogram of lateness
delay_hist <- ggplot(all_data, aes(x = diff)) +
  geom_bar(stat = "bin", 
           binwidth = 1, 
           colour = 'lightblue', 
           fill = 'cornflowerblue') +
  theme_minimal() +
  geom_point(aes(x = diff, y = 0), 
             alpha = 0.25, 
             size = 3, 
             fill = "darkgrey") +
  labs(y = "Number of Press Conferences", 
       x = "Minutes Late",
       title = "How Late was Mark McGowan?",
       subtitle = "Bars count the lateness by minute between December 1, 2020 and July 5, 2021") +
  scale_x_continuous(breaks = seq(0, 35, by = 2),
                     minor_breaks = seq(0, 35, by = 1))  +
 theme(plot.title = element_text(face = "bold"),
       panel.grid.minor.y = element_blank())

# Kaplan Meier Estimate
fit <- survfit(Surv(diff) ~ 1, data = all_data)

# Plot event probability
km_curve <- ggsurvplot(fit = fit,
                       conf.int = TRUE,
                       fun = "event",
                       ylab = "Probability Mark has Begun",
                       xlab = "Minutes Late",
                       surv.median.line = "hv",
                       break.x.by = 2,
                       conf.int.fill = "#FF7D71",
                       xlim = c(0, 35),
                       title = "When will Mark McGowan Begin?",
                       subtitle = "Estimated probability of press conference starting by minute after scheduled start",
                       ggtheme = theme_minimal())

km_curve <- km_curve$plot + theme(legend.position = "none",
                                  plot.title = element_text(face = "bold"))

# Join up plots using patchwork
combined_plot <- (delay_hist / km_curve) +  plot_layout(heights = c(1, 1.5))

# Save
ggsave(filename = here("Waiting_for_Mark/analysis/lateness_plots.png"),
       plot = combined_plot,
       device = "png",
       height = 5.51,
       width = 6.25,
       units = "in")
