class UrlApi {
  final url = 'https://api-myrekso.reksoratan-indonesia.com';

  late String login = '$url/api/login';
  late String profile = '$url/api/profile';
  late String logout = '$url/api/logout';

  // hr
  // employee
  late String employee = '$url/api/master/employee';

  // attendance
  late String attendance = '$url/api/hr/attendance';
  late String alreadyAbsence = '$url/api/hr/attendance/absent';
  late String notAbsence = '$url/api/hr/attendance/pending-absent';
  late String countAttendance = '$url/api/hr/attendance/count';
  late String storeAttendance = '$url/api/hr/attendance/store';
  late String destroyAttendance = '$url/api/hr/attendance/destroy';

  // announcement
  late String announcement = '$url/api/hr/anouncement';
  // end hr

  // waste collections
  // daily task
  late String dailyTask = '$url/api/wc/daily-task';
  late String dailyTaskWasteUserLogin = '$url/api/wc/daily-task/user';
  late String storeDailyTask = '$url/api/wc/daily-task/store';
  late String updateDailyTask = '$url/api/wc/daily-task/update'; // + id
  late String getImageWhereDailyTask = '$url/api/wc/task/attachment'; // + id
  late String storeImageDailyTask = '$url/api/wc/task/attachment/store'; // + id
  late String deleteImageDailyTask =
      '$url/api/wc/task/attachment/destroy'; // + id
  // monitoring
  late String taskGroupTeams = '$url/api/wc/daily-task/group-users';
  late String taskWhereTeams = '$url/api/wc/daily-task/user'; // + id
  // end waste collections

  // user
  late String allUser = '$url/api/master/user';
  // end user

  // compactor
  late String dailyTaskCompactor = '$url/api/cp/daily-task';
  late String compactorByCp = '$url/api/cp/daily-task/collection-point';
  late String dailyTaskCompactorTeam = '$url/api/cp/daily-task/user';
  late String storeDailyTaskCompactor = '$url/api/cp/daily-task/store';
  late String updateDailyTaskCompactor =
      '$url/api/cp/daily-task/update'; // + id
  late String getImageWhereDailyTaskCompactor =
      '$url/api/cp/task/attachment'; // + trans_dta_id
  late String storeImageDailyTaskCompactor =
      '$url/api/cp/task/attachment/store';
  late String deleteImageDailyTaskCompactor =
      '$url/api/cp/task/attachment/destroy'; // + id
  // end compactor

  // pruning
  late String taskGroupTeamsPr = '$url/api/pr/daily-task/group-users';
  late String taskWhereTeamsPr = '$url/api/pr/daily-task/user'; // + user_id
  late String dailyTaskPr = '$url/api/pr/daily-task';
  late String dailyTaskWherePrTeamLogin = '$url/api/pr/daily-task/user';
  late String storeDailyTaskPr = '$url/api/pr/daily-task/store';
  late String updateDailyTaskPr =
      '$url/api/pr/daily-task/update'; // + id / trans_dta_id
  late String getImageWhereDailyTaskPr =
      '$url/api/pr/task/attachment'; // + trans_dta_id
  late String storeImageDailyTaskPr = '$url/api/pr/task/attachment/store';
  late String deleteImageDailyTaskPr =
      '$url/api/pr/task/attachment/destroy'; // + id
  // end pruning

  // machine
  late String machines = '$url/api/master/machines';
  late String machinesUpdate = '$url/api/master/machines/update'; // + id

  // road sweeper
  late String dailyTaskRs = '$url/api/sc/daily-task';
  late String taskGroupTeamsRs = '$url/api/sc/daily-task/group-users';
  late String taskWhereTeamsRs = '$url/api/sc/daily-task/user'; // + id;
  late String taskWhereTeamsLoginRs = '$url/api/sc/daily-task/user';

  late String storeDailyTaskRs = '$url/api/sc/daily-task/store';
  late String updateDailyTaskRs =
      '$url/api/sc/daily-task/update'; // + trans_dtsc_id

  late String getImageWhereDailyTaskRs =
      '$url/api/sc/task/attachment'; // + trans_dtsc_id
  late String storeImageDailyTaskRs = '$url/api/sc/task/attachment/store';
  late String deleteImageDailyTaskRs =
      '$url/api/sc/task/attachment/destroy'; // + id
  // end road sweeper

  // manual sweeper
  late String dailyTaskMs = '$url/api/ms/daily-task';
  late String taskGroupTeamsMs = '$url/api/ms/daily-task/group-users';
  late String taskWhereTeamsMs = '$url/api/ms/daily-task/user'; // + id;
  late String taskWhereTeamsLoginMs = '$url/api/ms/daily-task/user';

  late String storeDailyTaskMs = '$url/api/ms/daily-task/store';
  late String updateDailyTaskMs =
      '$url/api/ms/daily-task/update'; // + trans_dtsc_id

  late String getImageWhereDailyTaskMs =
      '$url/api/ms/task/attachment'; // + trans_dtsc_id
  late String storeImageDailyTaskMs = '$url/api/ms/task/attachment/store';
  late String deleteImageDailyTaskMs =
      '$url/api/ms/task/attachment/destroy'; // + id
  // end manual sweeper

  // project
  late String getAllProject = '$url/api/master/project';
  // end project

  // special task
  late String getSources = '$url/api/special-task/sources';
  late String getSpecialTask = '$url/api/special-task';
  late String storeSpecialTask = '$url/api/special-task/store';
  late String updateSpecialTask = '$url/api/special-task/update'; // + id
  late String updateStatusSpecialTask =
      '$url/api/special-task/update-status'; // + id
  late String deleteSpecialTask = '$url/api/special-task/destroy'; // + id
  // detail special task
  late String getDetailSpecialTask =
      '$url/api/special-task/detail'; // + headerStId
  late String storeDetailSpecialTask = '$url/api/special-task/detail/store';
  late String deleteDetailSpecialTask =
      '$url/api/special-task/detail/destroy'; // + id
  // end special task

  // master locations categories
  late String getMLocationCategories = '$url/api/master/location-categories';
  // end master locations categories
  // master locations
  late String getMLocation = '$url/api/master/location'; // + id_location_a
  late String storeMLocation = '$url/api/master/location/store';
  late String updateMLocation = '$url/api/master/location/update'; // + id
  late String deleteMLocation = '$url/api/master/location/destroy'; // + id
  // end master locations

  // master daily task category
  late String mDailyTaskCategory = '$url/api/master/daily-task/category';
  late String mDailyTaskCategorySc = '$url/api/master/daily-task-sc/category';
  // end master daily task category
  // master daily task
  late String mDailyTask = '$url/api/master/daily-task';
  late String mDailyTaskSc = '$url/api/master/daily-task-sc';
  // end master daily task

  // master detail daily task
  late String getMDetailDailyTask =
      '$url/api/master/daily-task/detail'; // + daily_task_id
  late String getMDetailDailyTaskSc =
      '$url/api/master/daily-task-sc/detail'; // + dailytask_sc_id

  late String storeMDetailDailyTask = '$url/api/master/daily-task/detail/store';
  late String storeMDetailDailyTaskSc =
      '$url/api/master/daily-task-sc/detail/store';

  late String updateMDetailDailyTask =
      '$url/api/master/daily-task/detail/update'; // + id
  late String updateMDetailDailyTaskSc =
      '$url/api/master/daily-task-sc/detail/update'; // + id

  late String deleteMDetailDailyATask =
      '$url/api/master/daily-task/detail/destroy'; // + id
  late String deleteMDetailDailyATaskSc =
      '$url/api/master/daily-task-sc/detail/destroy'; // + id
  // end master detail daily task

  // budget
  // category budget
  late String getTypeCategoryBudget = '$url/api/master/type/budgets';
  late String categoryBudget = '$url/api/master/budgets';
  late String updateCategoryBudget = '$url/api/master/budgets/update'; // + id

  late String assignmentCategoryBudget = '$url/api/master/budget-assigment';
  late String updateAssignmentCategoryBudget =
      '$url/api/master/budget-assigment/update'; // + id
  // end category budget

  // budget operator
  late String getCategoryByUser = '$url/api/budgeting/category/user';
  late String budgetOperator = '$url/api/budgeting/operator';
  late String updateBudgetOperator =
      '$url/api/budgeting/operator/update'; // + id
  // end budget operator

  // budget completion
  late String budgetCompletion = '$url/api/completion';
  // end budget completion

  // submission not assignment
  late String getSubmissionNotAssignment =
      '$url/api/budgeting/list/all-operator';
  // end submission not assignment

  // add multiple submission
  late String insertMultipleSubmission =
      '$url/api/assigment/submision/completion';
  // end add multiple submission

  // delete submission from completion
  late String deleteSubmissionFromCompletion =
      '$url/api/assigment/submision/completion/destroy';
  // end delete submission from completion

  // list submission after add in detail completion
  late String getDetailCompletion =
      '$url/api/completion-detail'; // + penyelesaian_id
  // end list submission after add in detail completion

  // approval submission
  late String approvalSubmission = '$url/api/budgeting/approval'; // + budget_id
  // end approval submission
  // end budget

  // contract project
  late String mContractProject = '$url/api/project-contract';
  // end contract project
}
