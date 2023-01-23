# kohler_et_al_2023_ptrsb

[![Binder](https://mybinder.org/badge_logo.svg)](https://mybinder.org/v2/gh/village-ecodynamics/kohler_et_al_2023_ptrsb/master?urlpath=rstudio)

This repository contains the data and code for our paper:

> Kohler, Timothy A.
> [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-3414-6660),
> Darcy Bird
> [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0003-3466-6284),
> R. Kyle Bocinsky
> [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0003-1862-3428),
> Kelsey M. Reese
> [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0001-5127-7622), and
> Andrew Gillreath-Brown
> [![](https://orcid.org/sites/default/files/images/orcid_16x16.png)](https://orcid.org/0000-0002-2272-5542)
> (2023). Wealth Inequality in the Prehispanic Northern US Southwest: from Malthus to Tyche.
> *Philosophical Transactions of the Royal Society B*.

## Contents

[kohler_et_al_2023_ptrsb.R](/kohler_et_al_2023_ptrsb.R) is an R script that processes
all of the data and produces the figures that are presented in the article.

The [📂 figures](/figures) directory contains the figures produced by [kohler_et_al_2023_ptrsb.R](/kohler_et_al_2023_ptrsb.R), and included
in the article.

The [📂 data-raw](/data-raw) directory contains all data used 
in this analysis. Data are organized by the publication from which they
derive. Data include:

  - [📂 bocinsky_el_al_2016](/data-raw/bocinsky_el_al_2016):
  <br>Bocinsky, RK, Rush, J, Kintigh, KW, and Kohler, TA. (2016). 
  Exploration and exploitation in the macrohistory of the pre-Hispanic Pueblo Southwest. *Science Advances*, 2:e1501532.
    - [📄 bocinsky_et_al_2016_annual_data.xlsx](/data-raw/bocinsky_el_al_2016/bocinsky_et_al_2016_annual_data.xlsx): Data from Bocinsky et al. 2016, Fig. 2C.
  - [📂 gillreath-brown_et_al_submitted](/data-raw/gillreath-brown_et_al_submitted):
  <br>Gillreath-Brown, A, Bocinsky, RK, and Kohler, TA. (submitted). A Low-Frequency Summer Temperature Reconstruction for the United States Southwest, 3000 BC – AD 2000. *The Holocene*.
    - [📄 moberg-gillreath_ENSO.csv](/data-raw/gillreath-brown_et_al_submitted/moberg-gillreath_ENSO.csv): Data from the Gillreath-Brown et al. reconstruction of the El Niño Southern Oscillation.
    - [📄 supp_table_s2.csv](/data-raw/gillreath-brown_et_al_submitted/supp_table_s2.csv): Data from Gillreath-Brown et al., Supplemental Table S2.
  - [📂 kohler_et_al_2020_aarhus](/data-raw/kohler_et_al_2020_aarhus):
  <br>Kohler, TA, Ellyson, LJ, and Bocinsky, RK. (2023). Explaining Three Increasingly Large Collapses in the Northern Pueblo Southwest. In *Going forward by Looking Back: Archaeological Perspectives on Socio-Ecological Crisis, Response and Collapse*  (eds F Reide, P Sheets), pp. 304-332. New York: Berghahn Books.
    - [📄 vepiin_momentary_population.csv](/data-raw/kohler_et_al_2020_aarhus/vepiin_momentary_population.csv): Data from Kohler et al. 2020, Fig. 11.2.
  - [📂 kohler_et_al_2023_collapse](/data-raw/kohler_et_al_2023_collapse):
  <br>Kohler TA, Bocinsky RK, and Bird D. 2023 *Fluctuat nec mergitur*: Seven Centuries of Pueblo Crisis and Resilience. In *How Worlds Collapse: What History, Systems, and Complexity Can Teach Us about Our Modern World and Fragile Future* (eds MA Centeno, PW Callahan, P Larcey, T Patterson). New York: Routledge.
    - [📄 MergedGinis.csv](/data-raw/kohler_et_al_2023_collapse/MergedGinis.csv): Gini coeffecients for the Upland US Southwest
    - [📄 vep_ginis_period_centers.csv](/data-raw/kohler_et_al_2023_collapse/vep_ginis_period_centers.csv): Gini coeffecients for the VEPII CMV study region
  - [📂 kohler_reese_2014](/data-raw/kohler_reese_2014):
  <br>Kohler TA, Reese KM. 2014 Long and spatially variable Neolithic Demographic Transition in the North American Southwest. *Proceedings of the National Academy of Sciences* 111, 10101–10106.
    - [📄 kohler_reese2014_ndt.csv](/data-raw/kohler_reese_2014/kohler_reese2014_ndt.csv): Demographic and crude birth date data from Kohler and Reese 2014.
  - [📂 ortman_2016](/data-raw/ortman_2016):
  <br>Ortman SG. 2016 Uniform Probability Density Analysis and Population History in the Northern Rio Grande. *J Archaeol Method Theory* 23, 95–126.
    - [📄 fig6_vepii_demography_reconstructions.csv](/data-raw/ortman_2016/fig6_vepii_demography_reconstructions.csv): Data from Ortman 2016, Fig. 6.
  - [📂 reese_2021](/data-raw/reese_2021):
  <br>Reese KM. 2021 Deep learning artificial neural networks for non-destructive archaeological site dating. *J. Archaeol. Sci.* 132, 105413.
    - [📄 4-occupation-by-household-subregion.csv](/data-raw/reese_2021/4-occupation-by-household-subregion.csv): Modeled household occupation, with archaeological sites associated to VEPII CMV subregions as defined in Schwindt et al. 2016.
    - [📄 8-region-occupation-by-population.csv](/data-raw/reese_2021/8-region-occupation-by-population.csv): Final demographic reconstruction from Reese 2021.
  - [📂 schwindt_et_al_2016](/data-raw/schwindt_et_al_2016):
  <br>Schwindt DM, Kyle Bocinsky R, Ortman SG, Glowacki DM, Varien MD, Kohler TA. 2016 The Social Consequences of Climate Change in the Central Mesa Verde Region. *Am. Antiq.* 81, 74–96.
    - [📄 Schwindt_Table5.csv](/data-raw/schwindt_et_al_2016/Schwindt_Table5.csv): Data from Schwindt et al. 2016, Table 5.
    - [📄 vepii_cmv.fgb](/data-raw/schwindt_et_al_2016/vepii_cmv.fgb): A FlatGeobuf vector spatial file of the VEPII CMV subregions.
  - [📂 varien_et_al_2007](/data-raw/varien_et_al_2007):
  <br>Varien MD, Ortman SG, Kohler TA, Glowacki DM, Johnson CD. 2007 Historical Ecology in the Mesa Verde Region: Results from the Village Ecodynamics Project. *Am. Antiq.* 72, 273–300.
    - [📄 Varienetal2007_Table3.csv](/data-raw/varien_et_al_2007/Varienetal2007_Table3.csv): Data from Varien et al. 2007, Table 3.
    
  

## How to run in your browser

The simplest way to explore the code and data is to click on
[binder](https://mybinder.org/v2/gh/village-ecodynamics/kohler_et_al_2023_ptrsb/master?urlpath=rstudio)
to open an instance of RStudio in your browser, which will have the
compendium files ready to work with.

### Licenses

**Text and figures :**
[CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)

**Code :** [MIT](LICENSE.md)

**Data :** [CC-0](http://creativecommons.org/publicdomain/zero/1.0/)
attribution requested in reuse.
