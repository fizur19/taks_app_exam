class Urls {
  static final _baseurl = 'https://task.teamrabbil.com/api/v1';
  static final registration = "$_baseurl/registration";
  static final login = "$_baseurl/login";
  static final createTask = "$_baseurl/createTask";
  static final newtaskStatusCount = "$_baseurl/taskStatusCount";
  static final CompletedlistTaskByStatus =
      "$_baseurl/listTaskByStatus/Completed";

  static final newlistTaskByStatus = "$_baseurl/listTaskByStatus/New";
  static final ProgresslistTaskByStatus = "$_baseurl/listTaskByStatus/Progress";
  static final CancelledlistTaskByStatus =
      "$_baseurl/listTaskByStatus/Cancelled";

  static deleteTask(id) => "$_baseurl/deleteTask/$id";
  static dupdateTaskStatuseleteTask(id, status) =>
      "$_baseurl/updateTaskStatus/$id/$status";
  static final profileUpdate = "$_baseurl/profileUpdate";
  static String RecoverVerifyEmail(email) =>
      "$_baseurl/RecoverVerifyEmail/$email";
  static String RecoverVerifyOTP(email, otp) =>
      "$_baseurl/RecoverVerifyOTP/$email/$otp";

  static String RecoverResetPass = "$_baseurl/RecoverResetPass";
}
