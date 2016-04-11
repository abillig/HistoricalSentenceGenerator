# HistoricalSentenceGenerator

This basic CLI program lets you search for a word in any year between 1836 and 1922, and returns five random sentences containing that word lifted from newspaper articles written in the selected year. The program searches through catalogues of archived newspapers from all 50 states, randomly selecting both states and newspapers so that you get a different collection of five sentences each time you search. 

For example, search "Lincoln" in 1860 and you could get a selection of sentences from states in the North, the South, the East, and the West, giving a sense of everyday coverage of Lincoln from around the nation in year he was elected. 

I plan to turn this program into a data visualization of the states, and eventually to submit it to the National Endowment for the Humanities' Historic American Newspapers Data Challenge (https://www.challenge.gov/challenge/chronicling-america-historic-american-newspapers-data-challenge/).

I built the CLI to practice Ruby, as soon as I learned about the Nokogiri gem, which lets you parse HTML/XML. The program takes advantage of the Chronicling America API, which lets you access a database of hundreds of thousands of digitized newspapers from all 50 states. The API delivers OCR'd results, aka results of universities/libraries trying to turn image files of archival newspapers into machine readable text, and since the OCR is sometimes very faulty, the sentences sometimes don't exactly match what you'd see on the actual newspaper. The program's output is, after all, only as strong as its input, and OCR is far from perfect. That said, for each search result, I include a link to the actual digitized image of the newspaper, so you can investigate further. 

See the image files screenshot 1, screenshot 2, and screenshot 3 for some examples of the CLI at work. 
