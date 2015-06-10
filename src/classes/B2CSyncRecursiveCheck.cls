public class B2CSyncRecursiveCheck {
	public static Boolean alreadyRun = false;


	public static Boolean hasSyncAlreadyRun() {
		if (!alreadyRun) {
			alreadyRun = true;
			return false;
		}

		return alreadyRun;
	}
}