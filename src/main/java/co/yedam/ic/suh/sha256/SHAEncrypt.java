package co.yedam.ic.suh.sha256;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Random;

//https://javannspring.tistory.com/105 참고
/*
	SHA 256 암호화

 */
public class SHAEncrypt{
	public static String getEncrypt(String source, String salt) {
		return getEncrypt(source, salt.getBytes());
	}

	private static String getEncrypt(String source, byte[] salt) {

		String result = "";

		//이 밑에 3줄에서 암호화
		byte[] a = source.getBytes();
		byte[] bytes = new byte[a.length + salt.length];

		System.arraycopy(a, 0, bytes, 0, a.length);
		System.arraycopy(salt, 0, bytes, a.length, salt.length);

		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(bytes);

			byte[] byteData = md.digest();


			/*
			 * 음수까지 포함된 1바이트 데이터를 양수로 바꾸고 다시 1바이트를 더해 2바이트(16비트) 16진수 데이터로 바꾼후 두번쨰 글자부터
			 * 2글자식 짤라 최종 문자열에 더해감 그러면 최종으로 64개 길이의 문자열로 바뀜
			 * 256을 16진수로 변환하면 100이라 앞의 1을 지우기 위해 substring(1)로 유의미한 숫자인 두번쨰 글자부터 잘라 사용함
			 * 3글자로 만드는 과정을 안하면 9 이하의 숫자는 2글자식 잘라 사용하기 힘듬
			 */

			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < byteData.length; i++) {

				sb.append(Integer.toString((byteData[i] & 0xFF) + 256, 16).substring(1));
			}

			result = sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}

		return result;
	}

	public static String generateSalt() {
		//SecurityRandom 클래스도 있지만 일단 알아보지 않아 사용하지 않음
		Random random = new Random();

		byte[] salt = new byte[8];
		random.nextBytes(salt);

		StringBuffer sb = new StringBuffer();
		for (int i = 0; i < salt.length; i++) {
			// byte 값을 Hex 값으로 바꾸기.
			sb.append(String.format("%02x",salt[i]));
		}

		return sb.toString();
	}
}
