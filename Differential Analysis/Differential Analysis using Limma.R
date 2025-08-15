# Make sure EnhancedVolcano and ggplot2 are loaded
if (!requireNamespace("EnhancedVolcano", quietly = TRUE)) {
  BiocManager::install("EnhancedVolcano")
}
library(EnhancedVolcano)
library(ggplot2) # Explicitly load ggplot2 just to be safe

cat("\nGenerating Volcano Plot object...\n")

volcano_plot <- EnhancedVolcano(
  toptable = topDMPs_annotated,
  lab = topDMPs_annotated$Probe_ID,
  x = 'logFC',
  y = 'adj.P.Val',
  pCutoff = 0.05,
  FCcutoff = 0.1,
  title = 'Colon Cancer vs. Normal Colon: Differential Methylation',
  subtitle = 'Identified by limma-eBayes',
  caption = paste0('Total DMPs = ', nrow(topDMPs_annotated),
                   '\nSignificant (adj. P < 0.05) = ', nrow(subset(topDMPs_annotated, adj.P.Val < 0.05)),
                   '\nSignificant & Delta Beta > 0.1 = ', nrow(subset(topDMPs_annotated, abs(logFC) > 0.1))),
  pointSize = 1.0,
  labSize = 3.0,
  legendPosition = 'right',
  col = c('grey30', 'forestgreen', 'royalblue', 'red2'),
  colAlpha = 0.5,
  drawConnectors = TRUE,
  widthConnectors = 0.5,
  colConnectors = 'grey30'
)

# --- CRITICAL STEP: Explicitly print the plot ---
cat("\nPrinting Volcano Plot to RStudio Plots pane...\n")
print(volcano_plot) # This line makes the plot appear!

# --- Now try saving it (should work if plot appears) ---
cat("\nAttempting to save Volcano Plot...\n")
tryCatch({
  ggsave("Colon_Volcano_Plot.png", plot = volcano_plot, width = 10, height = 8, dpi = 300)
  cat("\nVolcano plot saved successfully to Colon_Volcano_Plot.png.\n")
}, error = function(e) {
  message("Error saving plot: ", e$message)
})

cat("\nFinished Volcano Plot operations. Check your RStudio Plots pane and working directory.\n")
