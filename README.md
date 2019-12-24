

<!--
 This is a  homework repository for https://github.com/haoyuns/Fall-2019
 
 作业可见：https://bookdown.org/Maxine/cuc-dataviz-/  
 
 Week 1 ：https://bookdown.org/Maxine/cuc-dataviz-/week-1.html  
 Week 2 ：https://bookdown.org/Maxine/cuc-dataviz-/week-2.html  
 Week 3 ：https://bookdown.org/Maxine/cuc-dataviz-/week-3.html   
 Week 4： https://bookdown.org/Maxine/plastic_problems/   过程和参考文献: https://bookdown.org/Maxine/cuc-dataviz-/week-4.html  
 Week 5 ~ 6： https://bookdown.org/Maxine/cuc-dataviz-/week-5-6.html  
 -->

# 期末作业过程描述   

https://www.rpubs.com/Maxine/american_school_diversity

选题想法： [Washington Post 的报道](https://www.washingtonpost.com/graphics/2019/local/school-diversity-data/)，数据量在 3 w 行以内，有天然的地理层级关系，适合分析结构。  

涉及数据： 

- 2017 年和 1995 年的学校多样性数据，经过 Washington Post 的预处理，可以在 https://github.com/WPMedia/student_integration_analysis/blob/master/output%20data/student_diversity_integration_output.csv 找到  

- 美国各州、部分学区的形状文件，通过 `tigris` 和 `tidycensus` 获得  

- 2017 年美国社区调查数据，通过 `tidycensus` 获得      

```r
# 种族人口分布
tidycensus::get_acs("state", variables = c(
 white = "C02003_003",
 black = "C02003_004",
 asian = "C02003_006",
 aian = "C02003_005",
 other = "C02003_008",
 multi = "C02003_009")
 
# 工资中位数                                       
tidycensus::get_acs("state", variables = c(
  "income" = "B19013_001",
  "white_income" = "B19013H_001",
  "black_income" = "B19013B_001",
  "aian_income" = "B19013C_001",
  "asian_income" = "B19013D_001",
  "other_income" = "B19013F_001",
  "multi_income" = "B19013G_001",
  "hispanic_income" = "B19013I_001"
))
                                       
                                   
```


视觉呈现的选择：  

- 分面地图、坡度图、三角坐标图描述 1995 年到 2017 年美国各州校园种族多样性的变化对比
- 山脊图以简洁的方式刻画 DI 在四个分区，两个年份的分布差异  
- 交互地图利于读者的探索性发现和分析  
- 散点图描述两个变量之间相关性  

内容框架：

1. 概述部分，应先让读者对 DI 变化趋势有基本认识
2. 描述性分析 DI 的（地理）分布特征
3. 结合文献，探究 DI 的影响的影响因素
   - 种族隔离 
   - 收入差距  
   
文件说明 
- final_update / final_update.Rmd 生成网页的源文件
- final_update / data 
  -  `student_integration_output.csv` Washington Post 提供的 1995 年和 2017 年美国各校区的多样性数据  
  - `region.csv` 美国各州所属的地理大区，用于山脊图
  - `least_diverse_shape.rds` 和 	`most_diverse_shape.rds`, 最多样和最不多样的 5 个州的形状文件，可用 `readr::read_rds()` 读取  
 -  `ggtern.R` 三角坐标图代码
 - `income.rds` 2017 年 ACS 中各州工资中位数
 - `res_seg.rds` 2017 年 ACS 中各州种族人口分布
