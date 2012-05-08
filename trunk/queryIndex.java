import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

public class queryIndex {
	 //main
	  public static void main(String[] args) throws IOException, ParseException {
		  String toSearch = "title";
		  String[] otherfieldsToDisplay = {"category"};
		 
		  //do multiple searches for each line in a file
		  try {
			    BufferedReader in = new BufferedReader(new FileReader("data\\titles.txt"));
			    String str;
			    while ((str = in.readLine()) != null) {
			    	searchIndex(toSearch, str, otherfieldsToDisplay);
			    }
			    in.close();
			} catch (IOException e) {
				System.out.println("error in reading input file\n");
			}
	  }
	  
	  //method to search in the index
	  public static void searchIndex(String searchField, String queryString, String[] otherFields) throws IOException, ParseException{	  
		  IndexSearcher searcher = new IndexSearcher(IndexReader.open(FSDirectory.open(new File("I:\\xiao-wikipedia\\lucene-index\\testIndex"))));
		  QueryParser parser = new QueryParser(Version.LUCENE_36, searchField, new StandardAnalyzer(Version.LUCENE_36));
		  System.out.println("\nsearching for - " + queryString + " -in field " + searchField);
		  Query query = parser.parse(queryString);
		  TopDocs results = searcher.search(query,10);
		  System.out.println("total hits: " + results.totalHits);
		  ScoreDoc[] hits = results.scoreDocs;
		  for (ScoreDoc hit : hits) {
	          Document doc = searcher.doc(hit.doc);
	//          System.out.printf("%5.3f %sn",
	//                            hit.score, doc.get("text"));
	          System.out.println(doc.get(searchField) + ": " + doc.get(otherFields[0]));
	      }
		  searcher.close();
	  }
}