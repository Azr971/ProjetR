library(tidyverse)

# Applications
View(txhousing)

# A partir du jeu de donn?es txhousing, 
# r?pondre aux demandes suivantes :

# 1. Distribution de la variable median
ggplot(txhousing, aes(median)) +
  geom_histogram() +
  theme_classic()

ggplot(txhousing, aes("", median)) +
  geom_jitter(alpha = .5) +
  geom_boxplot() +
  theme_classic()

# 2. Idem, en fonction de l'ann?e
ggplot(txhousing, aes(median, fill = factor(year))) +
  geom_histogram() +
  facet_grid(year ~ ., scales = "free_y") +
  theme_classic() +
  theme(legend.position = "none",
        axis.title.y = element_blank(),
        axis.text.y = element_blank(),
        axis.ticks.y = element_blank(),
        strip.text.y = element_text(angle = 0))

ggplot(txhousing, aes(factor(year), median, 
                      fill = factor(year),
                      col = factor(year))) +
  geom_jitter(alpha = .5) +
  geom_boxplot(color = "gray40") +
  theme_classic() +
  theme(legend.position = "none",
        axis.title.x = element_blank())

# 3. Lien entre median et sales
ggplot(txhousing, aes(sales, median)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_classic()

# 4. Idem, en fonction du mois et de l'ann?e
ggplot(txhousing, aes(sales, median)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, fullrange = T) +
  facet_grid(year ~ month) +
  theme_classic() +
  theme(axis.text = element_blank(),
        strip.text.y = element_text(angle = 0))

ggplot(txhousing, aes(sales, median)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, fullrange = T) +
  facet_wrap(~ month) +
  theme_classic()
ggplot(txhousing, aes(sales, median)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, fullrange = T) +
  facet_wrap(~ year) +
  theme_classic()

# 5. Evolution globale de median pour l'ensemble des villes
df = txhousing %>%
  group_by(date) %>%
  summarise(median = median(median, na.rm = T))
ggplot(txhousing, aes(date, median)) +
  geom_point(alpha = .2, color ="gray40") +
  geom_line(data = df, col = "steelblue", size = 2) +
  theme_classic()

# 6. Idem, par mois avec une couleur par ann?e
df = txhousing %>%
  group_by(date, year) %>%
  summarise(median = median(median, na.rm = T))
ggplot(df, aes(date, median, color = factor(year))) +
  #geom_point(alpha = .2) +
  geom_line(size = 2) +
  theme_classic() +
  theme(legend.position = "none",
        axis.title.x = element_blank())


df_mois = txhousing %>%
  group_by(month) %>%
  summarise(median = median(median, na.rm = T))
df_mois_annee = txhousing %>%
  group_by(year, month) %>%
  summarise(median = median(median, na.rm = T))
df_fin = df_mois_annee %>%
  summarise(median = last(median), month = last(month))
ggplot(df_mois_annee, aes(month, median)) +
  scale_x_continuous(breaks = 1:12, limits = c(1, 12.25)) +
  geom_line(aes(col = factor(year))) +
  geom_line(data = df_mois, size = 1.5,
            color = "steelblue") +
  geom_smooth(data = txhousing, se = FALSE, size = 1.5,
              color = "slategrey") +
  geom_text(data = df_fin, aes(label = year), 
            hjust = 0) +
  theme_classic() +
  theme(legend.position = "none",
        axis.title.x = element_blank())


ggplot(txhousing, aes(factor(month), median, fill = factor(year))) +
  geom_boxplot() +
  facet_wrap(~ year, scales = "free_y") +
  theme_classic() +
  theme(legend.position = "none",
        axis.title.x = element_blank())




anim <- ggplot(txhousing, aes(factor(month), median, fill = factor(year))) +
  geom_boxplot() +
  facet_wrap(~ year, scales = "free_y") +
  theme_classic() +
  theme(legend.position = "none",
        axis.title.x = element_blank())


library(plotly)
test<-ggplot(txhousing, aes(factor(city = "Houston"), sales, fill = factor(year))) +
         geom_point()
ggplotly(test)


# 3. Lien entre median et sales
ggplot(txhousing, aes(sales, volume)) +
  geom_point() + geom_boxplot() +
  geom_smooth(method = "lm", se = FALSE) +
  theme_classic()






library(ggplot2)
p1 <- ggplot(mtcars, aes(wt, mpg)) +
  geom_point()
p2 <- ggplot(mtcars, aes(factor(cyl))) +
  geom_bar()
p3 <- ggplot(mtcars, aes(factor(cyl), mpg)) +
  geom_violin()
p4 <- ggplot(mtcars, aes(factor(cyl), mpg)) +
  geom_boxplot()

txhousing$city == ausin
