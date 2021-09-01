package co.yedam.ic.hjs.aes256;

public class MainAES {
	public static void main(String[] args) throws Exception {
        String key = "aes256-test-key!!";       // key는 16자 이상
        AES256Util aes256 = new AES256Util(key);
         
        String text = "암호화되지 않은 문자입니다.";
        String encText = aes256.aesEncode(text);
        String decText = aes256.aesDecode(encText);
         
        System.out.println("암호화할 문자 : " + text);
        System.out.println("암호화된 문자 : " + encText);
        System.out.println("복호화된 문자 : " + decText);
    }
}
