library(here)
library(survival)
library(survminer)
library(patchwork)

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
       subtitle = "Bars count the lateness by minute between December 1, 2020 and July 3, 2021") +
  scale_x_continuous(breaks = seq(0, 33, by = 2),
                     minor_breaks = seq(0, 32, by = 1))  +
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
                       title = "When will Mark McGowan Begin?",
                       subtitle = "Estimated probability of press conference starting by minute after scheduled start",
                       ggtheme = theme_minimal())

km_curve <- km_curve$plot + theme(legend.position = "none",
                                  plot.title = element_text(face = "bold"))

# Join up plots using patchwork
(delay_hist / km_curve) +  plot_layout(heights = c(1, 1.5))
