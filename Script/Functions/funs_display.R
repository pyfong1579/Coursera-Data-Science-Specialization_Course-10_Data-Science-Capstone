## functions display.R

# Libraries
library(ggwordcloud)# word frequency visualizer.
library(ggplot2)    # Grammar of Graphics package for Visualizations.
library(grid)       # To manipulate visualizations.
library(gridExtra)  # supplement to grid.
library(RColorBrewer)# color palette.

fun.display <- function(x, title) {
    
    # Create ngram frequency display table.
    table <- tableGrob(x[1:10,1:3], rows = NULL)

    # Create Wordcloud
    wc <- ggplot(x[1:10,], aes(label= feature, size= frequency, color= frequency)) +
        geom_text_wordcloud() +
        scale_size_area(max_size= 12) +
        scale_color_distiller(palette = "YlOrRd", direction= 1) 
    
    # Create BarPlot
    plot <- ggplot(x[1:10, 1:2], aes(y = reorder(feature, frequency), x = frequency, fill = frequency)) +
        geom_bar(stat = "identity") +
        scale_fill_distiller(palette = "YlOrRd", direction= 1) +
        theme(legend.position= "none") +
        labs(y="Phrase")

# Create Coverage Plot
p <- cumsum(x$frequency)/sum(x$frequency)
p.5 <- which(p>=0.5)[1]; p.9 <<- (which(p>=.9)[1]); tit <<-title
p <- data.frame(p)
p$idx <- as.numeric(row.names(p))
names(p) <- c("pr","idx")
cover <- ggplot(p, aes(y= idx, x= pr, fill= pr)) +
    geom_col() +
    scale_fill_distiller(palette = "YlOrRd", direction= 1) +
    theme(legend.position= "none") +
    labs(y= "Phrase Count", x= "Probability of Coverage") +
    geom_vline(xintercept= 0.5, color= "steelblue", size = 1) +
    geom_vline(xintercept= 0.9, color= "steelblue", size = 1) +
    annotate("text", x = .45, y = p.5+1025, label = paste(format(p.5, big.mark= ","), "Phrases", "\n", "@ 50% Coverage")) +
    annotate("text", x = .85, y = p.9+1025, label = paste(format(p.9, big.mark= ","), "Phrases", "\n", "@ 90% Coverage"))

# Assemble Figure
layout <- rbind(c(1,2),
                c(3,4))
grid.arrange(table, cover, plot, wc,
             layout_matrix =layout,
             top= textGrob(paste("Top 10", title, "out of",
                                 format(dim(x)[1],big.mark= ","), sep= " "),
                           gp= gpar(fontsize= 20)))
}