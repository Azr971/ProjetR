mtcars
summary(mtcars)


ggplot(data=mtcars, aes(fill=factor(am), y=mpg, x=factor(cyl))) +geom_bar(stat="identity")+facet_wrap(~factor(am)) 



ggplot(diamonds, aes(color, carat)) +
    geom_boxplot() +
    facet_grid(facets = ~ cut)


ggplot(diamonds, aes(x = carat)) +
    geom_histogram() +
    facet_grid(facets = cut ~ ., scales = "free_y")



WP3 <- ggplot(data = WorldPhones_long, aes(x = Year, y = Nbr.Phones, group=Region, color=Region)) +
  geom_line() +
  geom_point() +
  ggtitle("Nombre de téléphones (en milliers) entre 1951 et 1961") +
  ylab("Nombre de téléphones") +
  xlab("Année")+
  theme_classic()+
  view_follow(fixed_x = TRUE, 
              fixed_y = FALSE) +
  transition_reveal(Year)


WP3 <- animate(WP3, end_pause = 15)

WP3


#https://cran.r-project.org/web/packages/esquisse/vignettes/get-started.html site où on peut avoir une interface click-boutton de ggplot2

esquisser(txhousing)


ggplot(diagnostics, aes(x=.hat, y=.std.resid, size=.cooksd)) + 
  geom_point(color=palette[2], alpha=.5) + 
  geom_point(data=subset(diagnostics, diagnostics$city==params$spotlight), color=palette[1])


txhousing


#https://larmarange.github.io/analyse-R/combiner-plusieurs-graphiques.html


# Correlation : Etude de la correlation entres les variables numériques
txhousing %>% 
  ggcorrmat(
    cor.vars = sales : date,
    matrix.type = "upper",
    sig.level = 0.05
    )
