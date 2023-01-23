library(tidyverse)

dir.create(
  here::here("figures")
)

# DONE Header info ----
pecos_long <-
  tibble::tibble(
    pecos = c("BMII", "BMIII", "PI", "EPII", "LPII", "EPIII", "LPIII"), #Bocinsky 2016 exploration/Exploitation ages
    StartDate = c(-500, 500, 700, 890, 1035, 1145, 1200),
    EndDate = c(500, 700, 890, 1035, 1145, 1200, 1285)) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(Year = list(StartDate:(EndDate - 1))) %>%
  tidyr::unnest(Year) %>%
  dplyr::select(pecos, Year) %>%
  dplyr::mutate(pecos = factor(pecos,
                               levels = unique(pecos),
                               ordered = TRUE))

pecos_simple <-
  tibble::tibble(
    pecos = c("BMII", "BMIII", "PI", "PII",  "PIII"), #Bocinsky 2016 exploration/Exploitation ages
    StartDate = c(340, 500, 700, 890, 1145),
    EndDate = c(500, 700, 890,  1145,  1285))

pecos_simple_long <-
  tibble::tibble(
    pecos = c("BMII", "BMIII", "PI", "PII",  "PIII"), #Bocinsky 2016 exploration/Exploitation ages
    StartDate = c(-500, 500, 700, 890, 1145),
    EndDate = c(500, 700, 890,  1145,  1285)) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(Year = list(StartDate:(EndDate - 1))) %>%
  tidyr::unnest(Year) %>%
  dplyr::select(pecos, Year) %>%
  dplyr::mutate(pecos = factor(pecos,
                               levels = unique(pecos),
                               ordered = TRUE))

Periods <- data.frame(
  Name = c("BMIII", "PI", "PII", "PIII",  "PIV",
           "EBM3", "LBM3", "EP1", "LP1",
           "EP2", "LP2", "EP3", "LP3"), #Bocinsky 2016 exploration/Exploitation ages
  StartDate = c( 500, 700,  890, 1145, 1285,
                 500, 600, 700, 790,
                 890, 1035, 1145, 1200),
  EndDate = c(700, 890, 1145, 1285, 1400,
              600, 700, 790, 890,
              1035, 1145, 1200, 1285),
  level = c(0, 0,  0, 0, 0,
            1, 1, 1, 1, 1, 1, 1, 1),
  Status = c("", "", "", "", "",
             "Explore", "Exploit","Explore", "Exploit",
             "Explore", "Exploit","Explore", "Exploit")) %>%
  rowid_to_column()


# FIGURE 1 A
ndt12_df <- readr::read_csv(
  here::here("data-raw",
             "kohler_reese_2014",
             "kohler_reese2014_ndt.csv")
)

Fig1A <-
  ggplot()+
  stat_smooth(data = ndt12_df %>%
                dplyr::filter((N_GE_5) >= 10),
              aes(x=Date_AD, y=`Crude Birth Rate`, weight=N_GE_5),
              method="loess",span=0.5,fullrange=TRUE,se=FALSE,
              linewidth = 0.5, color = "black") +
  geom_vline(data= pecos_simple,
             aes(xintercept = EndDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE)+
  geom_vline(data= pecos_simple,
             aes(xintercept = StartDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE) +
  geom_text(data= pecos_simple,
            aes(x=((EndDate+StartDate)/2), label = pecos, y = 0.06), vjust = -0.4) +
  coord_cartesian(xlim = c(400,1600), ylim = c(0.035,0.065)) +
  scale_x_continuous(breaks = seq(400,1600,100)) +
  scale_y_continuous( breaks = seq(0, 0.1, 0.01)) +
  theme_classic() +
  theme(
    legend.title = element_blank(),
    legend.background=element_blank(),
    legend.position = c(0.72, .5),
    legend.justification = "left",
    axis.title.x=element_blank(),
    axis.text.x = element_blank(),
    axis.title.y = element_text(size = 11),
    plot.margin = margin(4, 4, 4, 4, unit = "pt")
  )


# FIGURE 1 B
schwindt_vepiin_pop <-
  read_csv(
    here::here("data-raw",
               "kohler_et_al_2020_aarhus",
               "vepiin_momentary_population.csv")
  ) %>%
  dplyr::rename(`Schwindt 2016`= `Momentary population`) %>%
  dplyr::select(Year, `Schwindt 2016`)


reese_vepiin_pop <-
  read_csv(
    here::here("data-raw",
               "reese_2021",
               "8-region-occupation-by-population.csv")
  ) %>%
  dplyr::rename(Year = `...1`,
                `Reese 2021` = V1) %>%
  dplyr::mutate(`Reese 2021` = `Reese 2021` * 6)



Fig1B <-
  schwindt_vepiin_pop %>%
  dplyr::left_join(reese_vepiin_pop , by = "Year") %>%
  tidyr::pivot_longer(cols = c(`Reese 2021`, `Schwindt 2016`)) %>%
  ggplot() +
  geom_line(aes(x = Year, y = value, linetype = name), linewidth= 0.5) +
  scale_linetype_manual(values = c("dashed", "solid"))+
  geom_vline(data= pecos_simple,
             aes(xintercept = EndDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE)+
  geom_vline(data= pecos_simple,
             aes(xintercept = StartDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE) +
  scale_x_continuous(limits = c(400, 1600), breaks = seq(400,1600,100))+
  scale_y_continuous(limits = c(0, 30000), breaks = seq(0,30000,10000))+
  theme_classic()+
  theme(
    legend.title = element_blank(),
    legend.background=element_blank(),
    legend.position = c(0.72, .5),
    legend.justification = "left",
    axis.title.x=element_blank(),
    axis.text.x = element_blank(),
    axis.title.y = element_text(size = 11),
    plot.margin = margin(4, 4, 4, 4, unit = "pt"))+
  ylab("VEPIIN population")



# FIGURE 1 C
ortman_vepiis_pop <- read_csv(
  here::here("data-raw",
             "ortman_2016",
             "fig6_vepii_demography_reconstructions.csv")
) %>%
  dplyr::filter(`Study Area` == "NRG") %>%
  dplyr::rowwise() %>%
  dplyr::mutate(Year = list(Start:(End - 1))) %>%
  tidyr::unnest(Year) %>%
  dplyr::rename(`VEPII-S population` = Population) %>%
  dplyr::select(Year, `VEPII-S population`)


Fig1C <-
  ortman_vepiis_pop %>%
  ggplot() +
  geom_line(aes(x = Year, y = `VEPII-S population`)) +
  scale_x_continuous(limits = c(400, 1600), breaks = seq(400,1600,100))+
  scale_y_continuous(limits = c(0, 30000), breaks = seq(0,30000,10000))+
  theme_classic()+
  theme(
    legend.title = element_blank(),
    legend.background=element_blank(),
    legend.position = c(.02, .5),
    legend.justification = "left",
    axis.title.x=element_blank(),
    axis.text.x = element_blank(),
    axis.title.y = element_text(size = 11),
    plot.margin = margin(4, 4, 4, 4, unit = "pt"))+
  ylab("VEPIIS population")






# FIGURE 1 D
varien_occupation <- readr::read_csv(
  here::here("data-raw",
             "varien_et_al_2007",
             "Varienetal2007_Table3.csv")
) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(Year = list(Begin:(End - 1))) %>%
  tidyr::unnest(Year) %>%
  dplyr::select(
    Year,`Occupation Small sites`, `Occupation Community centers`
  ) %>%
  dplyr::rename(
    `Small Sites` = `Occupation Small sites`,
    `Community Centers` = `Occupation Community centers`
  )


Fig1D <-
  varien_occupation %>%
  tidyr::pivot_longer(cols = c(`Small Sites`, `Community Centers`)) %>%
  ggplot() +
  geom_line(aes(x = Year, y = value, linetype = name)) +
  geom_vline(data= pecos_simple,
             aes(xintercept = EndDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE)+
  geom_vline(data= pecos_simple,
             aes(xintercept = StartDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE) +
  scale_x_continuous(limits = c(400, 1600), breaks = seq(400,1600,100))+
  scale_y_continuous(limits = c(0, 50), breaks = seq(0, 50, 10))+
  theme_classic()+
  theme(
    legend.title = element_blank(),
    legend.background=element_blank(),
    legend.position = c(0.72, .5),
    legend.justification = "left",
    axis.title.x=element_blank(),
    axis.text.x = element_blank(),
    axis.title.y = element_text(size = 11),
    plot.margin = margin(4, 4, 4, 4, unit = "pt")) +
  ylab("Length of House \n Occupation")


# FIGURE 1 E
mergedGinis <- readr::read_csv(
  here::here("data-raw",
             "kohler_et_al_2023_collapse",
             "MergedGinis.csv")
)

vep_ginis_period_centers<-readr::read_csv(
  here::here("data-raw",
             "kohler_et_al_2023_collapse",
             "vep_ginis_period_centers.csv")
)


Fig1E <-
  ggplot() +
  geom_errorbar(data = vep_ginis_period_centers,
                aes(x = midyear,
                    ymin=lwr.ci,
                    ymax=upr.ci,
                    width=0.0)) +
  geom_line(data= mergedGinis,
            aes(x= Year,
                y = `Gini index (linear lagged)`,
                linetype = Location),
            color = "black",
            linewidth = 0.5) +
  geom_vline(data= pecos_simple,
             aes(xintercept = EndDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE)+
  geom_vline(data= pecos_simple,
             aes(xintercept = StartDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE) +
  scale_x_continuous(limits = c(400, 1600), breaks = seq(400,1600,100))+
  theme_classic()+
  theme(
    legend.title = element_blank(),
    legend.background=element_blank(),
    legend.position = c(0.72, .5),
    legend.justification = "left",
    axis.title.y = element_text(size = 11),
    axis.text.x =  element_text(size = 11),
    axis.title.x = element_text(size = 11),
    plot.margin = margin(4, 4, 4, 4, unit = "pt")) +
  ylab("Gini index \n (linear lagged)")+
  xlab("Year AD")


# Combine Fig1 ----
library(patchwork)

patchwork <- Fig1A / Fig1B / Fig1C/  Fig1D / Fig1E

pdf("figures/Fig1_final.pdf", width = 6.5, height = 8)
patchwork + plot_annotation(tag_levels = 'A')
dev.off()


# FIGURE 2 A
AGB_reconst <- readr::read_csv(
  here::here("data-raw",
             "gillreath-brown_et_al_submitted",
             "supp_table_s2.csv")
)

Fig2A <- AGB_reconst %>%
  ggplot() +
  geom_errorbar(aes(x = Year,
                    ymin = `Temperature Anomaly (°C)` - `Standard Error`,
                    ymax = `Temperature Anomaly (°C)` + `Standard Error`),
                color = "gray90") +
  geom_line(aes(x = Year, y = `Temperature Anomaly (°C)`)) +
  geom_vline(data= pecos_simple,
             aes(xintercept = EndDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE)+
  geom_vline(data= pecos_simple,
             aes(xintercept = StartDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE) +
  geom_hline(yintercept = 0) +
  geom_text(data= pecos_simple,
            aes(x=((EndDate+StartDate)/2), label = pecos, y = 0.5), vjust = -0.4)+
  scale_x_continuous(limits = c(400, 1600), breaks = seq(300,1600,100))+
  scale_y_continuous(limits = c(-2.5, 0.75), breaks = seq(-3, 3, 0.5))+
  theme_classic()+
  theme(
    legend.title = element_blank(),
    legend.background=element_blank(),
    legend.position = c(.02, .5),
    legend.justification = "left",
    axis.title.x=element_blank(),
    axis.text.x = element_blank(),
    axis.title.y = element_text(size = 11),
    plot.margin = margin(4, 4, 4, 4, unit = "pt"))+
  ylab("Temperature \n Anomaly (°C)")+
  xlab("Year AD")



# FIGURE 2 B
AGB_ENSO <- readr::read_csv(
  here::here("data-raw",
             "gillreath-brown_et_al_submitted",
             "moberg-gillreath_ENSO.csv")
) %>%
  dplyr::mutate(dominance = factor(ifelse(diff < 0, "El Niño", "La Niña")))

Fig2B <-
  AGB_ENSO %>%
  ggplot() +
  geom_line(aes(x = year, y = diff)) +
  geom_vline(data= pecos_simple,
             aes(xintercept = EndDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE)+
  geom_vline(data= pecos_simple,
             aes(xintercept = StartDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  geom_text(x=600, y = -1.5, label = "El Niño", size  = 4) +
  geom_text(x=600, y = 1.5, label = "La Niña", size  = 4) +
  scale_x_continuous(limits = c(400, 1600), breaks = seq(300,1600,100))+
  scale_y_continuous(limits = c(-2.5, 3.5), breaks = seq(-2, 3, 1))+
  theme_classic()+
  theme(
    legend.title = element_blank(),
    legend.background=element_blank(),
    legend.position = c(.02, .5),
    legend.justification = "left",
    axis.title.x=element_blank(),
    axis.text.x = element_blank(),
    axis.title.y = element_text(size = 11),
    plot.margin = margin(4, 4, 4, 4, unit = "pt"))+
  ylab("Dominant  \n ENSO Phase")


# FIGURE 2 C  ----
movingAverage <- function(x,n){
  stats::filter(x = x,
                filter = rep(1/n, n),
                method = "convolution",
                sides = 1,
                circular = FALSE)
}

bocinsky_transformed <-
  readxl::read_excel(
    here::here("data-raw",
               "bocinsky_el_al_2016",
               "bocinsky_et_al_2016_annual_data.xlsx"),
    sheet = "Niche") %>%
  dplyr::mutate(`11 Year Smoothed Local Habitation Cells` = movingAverage(`Local Habitation Cells`, 11 ),
                `Room to Walk` = `Local Habitation Cells` - `All Cells`,
                `11 Year Smoothed Room to Walk` = movingAverage(`Room to Walk`, 11 ))



Fig2C <-
  bocinsky_transformed %>%
  ggplot() +
  geom_line(aes(x = Year, y = `11 Year Smoothed Local Habitation Cells`)) +

  geom_vline(data= pecos_simple,
             aes(xintercept = EndDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE)+
  geom_vline(data= pecos_simple,
             aes(xintercept = StartDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE) +
  scale_x_continuous(limits = c(400, 1600), breaks = seq(400,1600,100))+
  scale_y_continuous(limits = c(0.35, 1), breaks = seq(-0.4, 1, 0.2))+
  theme_classic()+
  theme(
    legend.title = element_blank(),
    legend.background=element_blank(),
    legend.position = c(.02, .5),
    legend.justification = "left",
    axis.title.x=element_blank(),
    axis.text.x = element_blank(),
    axis.title.y = element_text(size = 11),
    plot.margin = margin(4, 4, 4, 4, unit = "pt"))+
  ylab("Occupied Cells in \n Maize Niche")





# FIGURE 2 D ----
Fig2D <-
  bocinsky_transformed %>%
  ggplot() +
  geom_line(aes(x = Year, y = `11 Year Smoothed Room to Walk`)) +
  geom_vline(data= pecos_simple,
             aes(xintercept = EndDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE)+
  geom_vline(data= pecos_simple,
             aes(xintercept = StartDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE) +
  scale_x_continuous(limits = c(400, 1600), breaks = seq(400,1600,100))+
  scale_y_continuous(limits = c(-0.1, 0.45), breaks = seq(-0.5, 0.9, 0.1))+
  theme_classic()+
  theme(
    legend.title = element_blank(),
    legend.background=element_blank(),
    legend.position = c(.02, .5),
    legend.justification = "left",
    axis.title.x = element_text(size = 11),
    axis.text.x =  element_text(size = 11),
    axis.title.y = element_text(size = 11),
    plot.margin = margin(4, 4, 4, 4, unit = "pt"))+
  ylab("Room to Walk")+
  xlab("Year AD")


# Combine Figure 2 ----
library(patchwork)

patchwork <- Fig2A / Fig2B / Fig2C/  Fig2D

pdf("figures/Fig2_final.pdf", width = 6.5, height = 8)
patchwork + plot_annotation(tag_levels = 'A')
dev.off()





# Fig 3 Violin plots -----

## Reese household data include site locations. Here, we group by VEPII CMV
## subregions, and write out a new dataset sans specific site locations. This
## allows us to publish the site-specific data without revealing locational information.
# reese <-
#   readr::read_csv("data-raw/reese_2021/4-occupation-by-household.csv") %>%
#   sf::st_as_sf(coords = c("X_COORDS", "Y_COORDS"),
#                crs = 26912) %>%
#   sf::st_intersection(
#     sf::read_sf(here::here("data-raw",
#                            "schwindt_et_al_2016",
#                            "vepii_cmv.fgb")) %>%
#       sf::st_transform(crs = 26912) %>%
#       dplyr::select(subregion = Stratum)
#   ) %>%
#   sf::st_drop_geometry() %>%
#   readr::write_csv("data-raw/reese_2021/4-occupation-by-household-subregion.csv")

reese_long <-
  readr::read_csv(
    here::here(
      "data-raw",
      "reese_2021",
      "4-occupation-by-household-subregion.csv"
    )
  ) %>%
  tidyr::pivot_longer(cols = X450:X1300,
                      names_to = "year",
                      values_to = "nHouse") %>%
  dplyr::mutate(year = as.numeric (stringr::str_remove_all(year, "X"))) %>%
  dplyr::filter(year %in% c(570:1300))

schwindt_churn <-
  readr::read_csv(
    here::here("data-raw",
               "schwindt_et_al_2016",
               "Schwindt_Table5.csv")
  ) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(Year = list(From:(To - 1))) %>%
  tidyr::unnest(Year) %>%
  dplyr::select(Year, Churn) %>%
  dplyr::rename(Population = Churn, year = Year) %>%
  dplyr::mutate(subregion = "Churn",
                Population = Population * 500 + 300)

reese_long_subregions <-
  reese_long %>%
  dplyr::group_by(year, subregion) %>%
  dplyr::summarise(Population = sum(nHouse) * 6) %>%
  dplyr::ungroup() %>%
  dplyr::add_row(schwindt_churn) %>%
  dplyr::group_by(year, subregion) %>%
  dplyr::mutate(
    filltype = factor(ifelse(subregion == "Churn", "red", "gray95")),
    subregion =
      factor(subregion,
             levels= c("Hovenweep", "Ute Piedmont", "McElmo", "Mesa Verde Landform", "Mesa Verde National Park", "Dolores", "Churn"),
             labels = c("Hovenweep", "Ute \nPiedmont", "McElmo", "Mesa Verde \nLandform", "Mesa Verde \nNational Park", "Dolores", "Churn")))


Fig3 <-
  ggplot(reese_long_subregions, aes(x = subregion, y = year)) +
  geom_violin(stat = "identity", aes(violinwidth = 0.0002*Population, fill = factor(filltype))) +
  scale_fill_manual(values = c( "gray80", "tomato3"))+
  geom_hline(data= pecos_simple,
             aes(yintercept = EndDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE)+
  geom_hline(data= pecos_simple,
             aes(yintercept = StartDate),
             linetype = "dashed",
             show.legend = FALSE,
             na.rm=FALSE) +
  geom_text(data= pecos_simple,
            aes(y=((EndDate+StartDate)/2), label = pecos, x = 0.7), vjust = -0.4)+
  scale_y_continuous(limits = c(570, 1300), breaks = seq(500,1600,100))+
  theme_classic()+
  theme(
    legend.title = element_blank(),
    legend.background=element_blank(),
    legend.text = element_blank(),
    axis.title.x = element_text(size = 12, hjust= .42),
    axis.title.y = element_text(size = 12),
    axis.text.x = element_text(size = 9),
    axis.text.y = element_text(size = 10)
  )+
  guides(fill="none")+
  xlab("Subregion ")+
  ylab("Year AD")

pdf("figures/Fig3_final.pdf", width = 6, height = 4)
Fig3
dev.off()


