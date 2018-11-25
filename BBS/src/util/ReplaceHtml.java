package util;

public class ReplaceHtml {
	public static String getCode(String code) {
		
		return code.replaceAll(" ", "&nbsp;").replaceAll("<", "&lt").replaceAll(">", "&gt").replaceAll("\n", "<br>");
	}

}
