# display function
display <-function (ngramset,title) {
    # Create Table
    table <- tableGrob(ngramset[1:10,], rows = NULL)
    # Create Wordcloud
    wc <- ggplot(ngramset[1:10,], aes(label= Phrase, size= Frequency, color= Frequency)) +
        geom_text_wordcloud() +
        scale_size_area(max_size= 12) +
        scale_color_distiller(palette = "YlOrRd", direction= 1) 
    # Create BarPlot
    plot <- ggplot(ngramset[1:10,], aes(y = reorder(Phrase, Frequency), x = Frequency,
                                        fill = Frequency)) +
        geom_bar(stat = "identity") +
        scale_fill_distiller(palette = "YlOrRd", direction= 1) +
        theme(legend.position= "none") +
        labs(y="Phrase")
    # Create Coverage Plot
    p <- cumsum(ngramset$Frequency)/sum(ngramset$Frequency)
    p.5 <- which(p>+0.5)[1]; p.9 <- (which(p>=.9)[1])
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
        annotate("text", x = .45, y = 1025, label = paste(p.5, "Phrases", "\n", "@ 50% Coverage")) +
        annotate("text", x = .85, y = 1025, label = paste(p.9, "Phrases", "\n", "@ 90% Coverage"))
    # Assemble Figure
    layout <- rbind(c(1,2),
                    c(3,4))
    grid.arrange(table, cover, plot, wc,
                 layout_matrix =layout,
                 top= textGrob(paste("Top 10", title, "out of",
                                     as.character(dim(ngramset)[1]), sep= " "),
                               gp= gpar(fontsize= 20)))
}