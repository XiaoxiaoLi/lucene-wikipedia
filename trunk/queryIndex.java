import org.apache.lucene.analysis.standard.StandardAnalyzer;
import org.apache.lucene.document.Document;
import org.apache.lucene.document.Field;
import org.apache.lucene.index.IndexReader;
import org.apache.lucene.index.IndexWriter;
import org.apache.lucene.index.IndexWriterConfig;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.IndexSearcher;
import org.apache.lucene.search.Query;
import org.apache.lucene.search.ScoreDoc;
import org.apache.lucene.search.TopDocs;
import org.apache.lucene.search.TopScoreDocCollector;
import org.apache.lucene.store.Directory;
import org.apache.lucene.store.RAMDirectory;
import org.apache.lucene.store.FSDirectory;
import org.apache.lucene.util.Version;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.Hashtable;

public class queryIndex {
	 //main
	  public static void main(String[] args) throws IOException, ParseException {
		  String toSearch = "category";
		  String[] otherfieldsToSearch = {"title"};
		  searchIndex(toSearch, "cat2", otherfieldsToSearch);
	  }
	  
	  //method to search in the index
	  public static void searchIndex(String searchField, String queryString, String[] otherFields) throws IOException, ParseException{	  
		  IndexSearcher searcher = new IndexSearcher(IndexReader.open(FSDirectory.open(new File("testIndex"))));
		  QueryParser parser = new QueryParser(Version.LUCENE_36, searchField, new StandardAnalyzer(Version.LUCENE_36));
		  System.out.println("\nsearching for: " + queryString);
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