initialization
initializeCommandMappings
	" Still not generated, but it will. Override specific builders in initializeSpecificCommandMappings"

	commandDictionary
		at: #PASS_APPLICATION put: ATSPassApplication;
		at: #UNPASS_APPLICATION put: ATSUnpassApplication;
		at: #CREATE_EVALUATION put: ATSCreateEvaluation;
		at: #SEND_EVALUATION put: ATSSendEvaluation;
		at: #UPDATE_EVALUATION put: ATSUpdateEvaluation;
		at: #UPDATE_ROUND put: ATSUpdateRound;
		at: #CREATE_EVALUATOR put: ATSCreateEvaluator;
		at: #UPDATE_EVALUATOR put: ATSUpdateEvaluator;
		at: #DISABLE_EVALUATOR put: ATSDisableEvaluator;
		at: #ANONYMIZE_EVALUATOR put: ATSAnonymizeEvaluator;
		at: #ACCEPT_EVALUATION put: ATSAcceptEvaluation;
		at: #CREATE_ROUND put: ATSCreateRound;
		at: #CREATE_CONTEST put: ATSCreateContest;
		at: #UPDATE_CONTEST put: ATSUpdateContest;
		at: #CREATE_CATEGORY put: ATSCreateCategory;
		at: #CREATE_GROUP put: ATSCreateGroup;
		at: #CREATE_APPLICANT put: ATSCreateApplicant;
		at: #CREATE_APPLICATION put: ATSCreateApplication;
		at: #UPDATE_APPLICATION put: ATSUpdateApplication;
		at: #CREATE_TAG put: ATSCreateTag;
		at: #UPDATE_TAG put: ATSUpdateTag;
		at: #ASSIGN_TAGS put: ATSAssignTags;
		at: #UPDATE_I18N_TAG put: ATSUpdateI18nTag;
		at: #ADD_CATEGORY_TO_TAG put: ATSAddCategoryToTag;
		at: #ADD_CONTEST_TO_TAG put: ATSAddContestToTag;
		at: #REMOVE_CONTEST_FROM_TAG put: ATSRemoveContestFromTag;
		at: #REMOVE_CATEGORY_FROM_TAG put: ATSRemoveCategoryFromTag;
		at: #CREATE_REGION put: ATSCreateRegion;
		at: #CREATE_SKILL_TYPE put: ATSCreateSkillType;
		at: #CREATE_COUNTRY put: ATSCreateCountry;
		at: #RELATE_COUNTRY put: ATSRelateCountry;
		at: #RELATE_SKILL_TYPE put: ATSRelateSkillType;
		at: #UPDATE_APPLICANT put: ATSUpdateApplicant;
		at: #UPDATE_REGION put: ATSUpdateRegion;
		at: #UPDATE_SKILL_TYPE put: ATSUpdateSkillType;
		at: #CREATE_FORM put: ATSCreateForm;
		at: #UPDATE_FORM put: ATSUpdateForm;
		at: #ACCEPT_INVITATION put: ATSAcceptInvitation;
		at: #UPDATE_GROUP put: ATSUpdateGroup;
		at: #CLOSE_ROUND put: ATSCloseRound;
		at: #ADD_EVALUATOR put: ATSAddEvaluator;
		at: #REMOVE_EVALUATOR put: ATSRemoveEvaluator;
		at: #CREATE_HISTORY_GROUP_CONFIG put: ATSCreateHistoryGroupConfig;
		at: #UPDATE_HISTORY_GROUP_CONFIG put: ATSUpdateHistoryGroupConfig;
		at: #CREATE_ENTITY put: ATSCreateEntity;
		at: #UPDATE_ENTITY put: ATSUpdateEntity;
		at: #NEW_TOKEN_GENERATED put: ATSUpdateApplication;
		at: #UPDATE_APPLICATION_TOKEN put: ATSUpdateApplicationToken;
		at: #UPDATE_TAG_DESCRIPTION put: ATSUpdateTagDescription;
		at: #NEW_TOKEN_WITH_NO_RECOVER_PERMIT_REQUESTED
			put: ATSNewTokenWithNoRecoverPermitRequested;
		at: #NEW_TOKEN_FOR_NONEXISTENT_APPLICANT_REQUESTED
			put: ATSNewTokenForNonexistentApplicantRequested;
		at: #DISCARD_EVALUATION
			put: ATSDiscardEvaluation 