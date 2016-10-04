BeginTestSection["DSL"]

BeginTestSection["A Domain Specific Language (DSL) for Legal Rules - Unit Tests"]

BeginTestSection["Information-Seeking"]

BeginTestSection["Identifying Needed Inputs"]

BeginTestSection["ApplyRules"]

(* ::Text:: *)
(*Unit tests:*)

VerificationTest[(* 1 *)
	ApplyRules[List[qualifyingRelationship["Lucy", "Sam"]], Association[Rule[age["Lucy"], 21], Rule[gender["Sam"], "Female"]]]
	,
	List[True]	
	,
	TestID->"dc311d48-8306-4cb3-8c44-a696d7030ed9"
]

VerificationTest[(* 2 *)
	ApplyRules[List[qualifyingRelationship["Lucy", "Sam"]], Association[Rule[age["Lucy"], 6], Rule[gender["Sam"], "Female"]]]
	,
	List[False]	
	,
	TestID->"b210b799-ce54-40b5-ab5c-25c01a727123"
]

VerificationTest[(* 3 *)
	ApplyRules[List[qualifyingRelationship["Lucy", "Sam"]], Association[Rule[age["Lucy"], 6]]]
	,
	List[False]	
	,
	TestID->"52bbb27a-b6d2-4e7f-967b-cf00edd4dcda"
]

VerificationTest[(* 4 *)
	ApplyRules[List[qualifyingRelationship["Lucy", "Sam"]], Association[]]
	,
	List[And[Greater[Ask[age["Lucy"]], 18], Equal[Ask[gender["Sam"]], "Female"]]]	
	,
	TestID->"c5a739c5-dce7-4399-9be7-47887675f1b6"
]

VerificationTest[(* 5 *)
	ApplyRules[List[qualifyingRelationship["Lucy", "Sam"]], Association[Rule[age["Lucy"], 22]]]
	,
	List[Equal[Ask[gender["Sam"]], "Female"]]	
	,
	TestID->"77ac1e95-c2a0-4e35-b6d8-14c1da285704"
]

EndTestSection[]

BeginTestSection["MissingData"]

VerificationTest[(* 6 *)
	MissingData[ApplyRules[List[qualifyingRelationship["Lucy", "Sam"]], Association[]]]
	,
	List[age["Lucy"], gender["Sam"]]	
	,
	TestID->"6e477025-d158-468e-9b24-561fe2a72b08"
]

VerificationTest[(* 7 *)
	MissingData[ApplyRules[List[qualifyingRelationship["Lucy", "Sam"]], Association[Rule[age["Lucy"], 22]]]]
	,
	List[gender["Sam"]]	
	,
	TestID->"be1e44aa-8847-4884-a00e-b27d07bbfeb7"
]

VerificationTest[(* 8 *)
	MissingData[ApplyRules[List[qualifyingRelationship["Lucy", "Sam"]], Association[Rule[age["Lucy"], 6], Rule[gender["Sam"], "Female"]]]]
	,
	List[]	
	,
	TestID->"05f59c06-5216-4541-88b3-725a38f844b9"
]

EndTestSection[]

EndTestSection[]

EndTestSection[]

BeginTestSection["Handling Uncertainty"]

BeginTestSection["Merging Uncertain States Together"]

VerificationTest[(* 9 *)
	mergeStubs[List[RuleStub["x"], RuleStub["y"]]]
	,
	RuleStub[List["x", "y"]]	
	,
	TestID->"e5f0f6a6-c14c-443f-b2d2-055bfa6be035"
]

VerificationTest[(* 10 *)
	mergeStubs[List[RuleStub[], RuleStub["y"]]]
	,
	RuleStub[List["y"]]	
	,
	TestID->"1b0b033f-12a5-468d-9aac-0015befdd2cc"
]

VerificationTest[(* 11 *)
	mergeStubs[List[RuleStub[], RuleStub[]]]
	,
	RuleStub[]	
	,
	TestID->"cd8114d9-54ad-47b8-9f42-f61e0b8a9b6a"
]

VerificationTest[(* 12 *)
	mergeUncertains[List[Uncertain["x"], Uncertain[f[x]]]]
	,
	Uncertain[List["x", f[x]]]	
	,
	TestID->"8fc1fb6d-c04c-47e8-8951-1d38e2061153"
]

EndTestSection[]

BeginTestSection["Short-Circuit Operations"]

VerificationTest[(* 13 *)
	staticAnd[True, False]
	,
	False	
	,
	TestID->"d9bc19b2-fc75-4873-b194-e4f369ab0dd5"
]

VerificationTest[(* 14 *)
	staticAnd[True, RuleStub[]]
	,
	RuleStub[]	
	,
	TestID->"611b2409-b09b-4a77-9fd3-c046cca36f7b"
]

VerificationTest[(* 15 *)
	staticOr[True, RuleStub[]]
	,
	True	
	,
	TestID->"5662072e-bacd-4752-8926-b38c10858700"
]

VerificationTest[(* 16 *)
	staticOr[Uncertain[], RuleStub[]]
	,
	Uncertain[]	
	,
	TestID->"348dfab3-64bb-47c6-8280-fd0210bb7905"
]

VerificationTest[(* 17 *)
	staticTimes[0, RuleStub[]]
	,
	0	
	,
	TestID->"f9f084c2-ec40-4f54-a33e-5fd2443640fe"
]

VerificationTest[(* 18 *)
	staticTimes[Uncertain[], RuleStub[]]
	,
	RuleStub[]	
	,
	TestID->"052cb6d1-ceb6-47e6-b108-91409a20103a"
]

EndTestSection[]

BeginTestSection["HandleUncertainty"]

VerificationTest[(* 19 *)
	handleUncertainty[And[False, True], And, List[False, True]]
	,
	False	
	,
	TestID->"afe1647e-c163-4633-b33f-6078bb357395"
]

VerificationTest[(* 20 *)
	handleUncertainty[And[RuleStub[], True], And, List[RuleStub[], True]]
	,
	RuleStub[]	
	,
	TestID->"fde32e7f-5907-4b4b-ba05-cbe6ea45a26e"
]

EndTestSection[]

EndTestSection[]

BeginTestSection["Time Series Operations"]

BeginTestSection["TimeLine"]

BeginTestSection["TimeLine"]

VerificationTest[(* 21 *)
	MakeTimeLine[List[List[List[2000, 1, 1], False], List[List[2011, 1, 1], True]]]
	,
	TimeLine[List[List[3155673600, False], List[3502828800, True]]]	
	,
	TestID->"32abce40-5c1a-45f5-a848-bb640924e06d"
]

VerificationTest[(* 22 *)
	T[List[List[List[2000, 1, 1], False], List[List[2011, 1, 1], True]]]
	,
	TimeLine[List[List[3155673600, False], List[3502828800, True]]]	
	,
	TestID->"32ca9cd7-489b-4c44-a4ed-dd549dbe52d7"
]

VerificationTest[(* 23 *)
	ShowTimeLine[TimeLine[List[List[3155673600, False], List[3502828800, True]]]]
	,
	List[List[List[2000, 1, 1], False], List[List[2011, 1, 1], True]]	
	,
	TestID->"e77955e6-77e6-4a96-9cca-29ee6c4fdc08"
]

EndTestSection[]

BeginTestSection["Internal Machinery"]

VerificationTest[(* 24 *)
	TimeLineValues[MakeTimeLine[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]]]
	,
	List[True, False]	
	,
	TestID->"28d8a0bd-4c01-44cb-ae2c-06995b1b6924"
]

EndTestSection[]

BeginTestSection["AsOf"]

VerificationTest[(* 25 *)
	AsOf[List[2005, 3, 3], MakeTimeLine[List[List[List[2000, 1, 1], 483], List[List[2010, 1, 1], 222]]]]
	,
	483	
	,
	TestID->"3b32030d-df76-4980-8139-44e4bbde0453"
]

VerificationTest[(* 26 *)
	AsOf[List[2005, 3, 3], MakeTimeLine[List[List[List[2000, 1, 1], 483], List[List[2010, 1, 1], RuleStub[]]]]]
	,
	483	
	,
	TestID->"c758c171-2742-4aa3-bde6-39efebb187e8"
]

VerificationTest[(* 27 *)
	AsOf[List[2005, 3, 3], MakeTimeLine[List[List[List[2000, 1, 1], Uncertain[]], List[List[2010, 1, 1], RuleStub[]]]]]
	,
	Uncertain[]	
	,
	TestID->"ca007a51-1243-4895-a78f-61b4b4ff0b36"
]

VerificationTest[(* 28 *)
	AsOf[RuleStub[], MakeTimeLine[List[List[List[2000, 1, 1], 483], List[List[2010, 1, 1], 222]]]]
	,
	RuleStub[]	
	,
	TestID->"28a190b5-ba35-4551-9346-6b16e8db25e3"
]

VerificationTest[(* 29 *)
	AsOf[Uncertain[], MakeTimeLine[List[List[List[2000, 1, 1], RuleStub[]], List[List[2010, 1, 1], 222]]]]
	,
	Uncertain[]	
	,
	TestID->"7d95e0c5-7859-40a8-bfa8-a8bd41c632f9"
]

EndTestSection[]

BeginTestSection["TimeLineMap"]

EndTestSection[]

BeginTestSection["TimeLineMapZip"]

EndTestSection[]

BeginTestSection["TimeLineWindow"]

VerificationTest[(* 30 *)
	ShowTimeLine[TimeLineWindow[theMonth, List[2017, 2, 2], List[2018, 3, 3]]]
	,
	List[List[List[2017, 3, 1], 3], List[List[2017, 4, 1], 4], List[List[2017, 5, 1], 5], List[List[2017, 6, 1], 6], List[List[2017, 7, 1], 7], List[List[2017, 8, 1], 8], List[List[2017, 9, 1], 9], List[List[2017, 10, 1], 10], List[List[2017, 11, 1], 11], List[List[2017, 12, 1], 12], List[List[2018, 1, 1], 1], List[List[2018, 2, 1], 2], List[List[2018, 3, 1], 3]]	
	,
	TestID->"c55c2e64-5096-4853-8dae-5611544fe4c5"
]

EndTestSection[]

BeginTestSection["TimeLineGenerator"]

VerificationTest[(* 31 *)
	ShowTimeLine[TimeLineGenerator[TimeLineWindow[theYear, List[2040, 1, 1], EndOfTime], Function[Power[Slot[1], 2]]]]
	,
	List[List[List[2040, 1, 1], 1], List[List[2041, 1, 1], 4], List[List[2042, 1, 1], 9], List[List[2043, 1, 1], 16], List[List[2044, 1, 1], 25], List[List[2045, 1, 1], 36], List[List[2046, 1, 1], 49], List[List[2047, 1, 1], 64], List[List[2048, 1, 1], 81], List[List[2049, 1, 1], 100], List[List[2050, 1, 1], 121]]	
	,
	TestID->"2c07c032-ac98-4c62-9615-96fd540ebbc8"
]

EndTestSection[]

BeginTestSection["Helper Functions"]

VerificationTest[(* 32 *)
	timeLineStartsAtDawn[theDate]
	,
	True	
	,
	TestID->"d32bda20-4c63-4df6-a735-86130382da98"
]

VerificationTest[(* 33 *)
	timeLineStartsAtDawn[MakeTimeLine[List[List[List[2090, 3, 3], False]]]]
	,
	False	
	,
	TestID->"637b9438-dc46-4044-805a-53c23226cffb"
]

EndTestSection[]

BeginTestSection["AnnualTimeLine"]

EndTestSection[]

EndTestSection[]

BeginTestSection["Boolean TimeLines"]

BeginTestSection["Boolean Operators"]

VerificationTest[(* 34 *)
	ShowTimeLine[And[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], T[List[List[List[2000, 1, 1], False], List[List[2005, 1, 1], True]]]]]
	,
	TimeLine[List[List[DawnOfTime, False], List[List[2005, 1, 1], True], List[List[2010, 1, 1], False]]]	
	,
	TestID->"7a3f786d-2daf-46e9-993f-9d173d4a2669"
]

VerificationTest[(* 35 *)
	ShowTimeLine[Or[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], T[List[List[List[2000, 1, 1], False], List[List[2005, 1, 1], True]]]]]
	,
	True	
	,
	TestID->"b18616e8-3b6d-46c1-80ce-70ed71f138b9"
]

VerificationTest[(* 36 *)
	ShowTimeLine[And[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], True]]
	,
	List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]	
	,
	TestID->"87280230-2d15-41df-a910-3ebfbf90d99f"
]

VerificationTest[(* 37 *)
	ShowTimeLine[And[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], False]]
	,
	False	
	,
	TestID->"2e68921e-0ba6-44de-b623-a87e3a36860a"
]

VerificationTest[(* 38 *)
	ShowTimeLine[And[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], RuleStub[]]]
	,
	List[List[List[2000, 1, 1], RuleStub[]], List[List[2010, 1, 1], False]]	
	,
	TestID->"bdec8849-286e-4249-a984-bfabc9585366"
]

VerificationTest[(* 39 *)
	ShowTimeLine[And[RuleStub[], T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]]]]
	,
	List[List[List[2000, 1, 1], RuleStub[]], List[List[2010, 1, 1], False]]	
	,
	TestID->"efa50fbf-913e-4eb9-8977-4bef8316dada"
]

VerificationTest[(* 40 *)
	ShowTimeLine[Or[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], True]]
	,
	True	
	,
	TestID->"fdeaa2b8-a224-4eb2-a17e-31bd053aa02a"
]

VerificationTest[(* 41 *)
	ShowTimeLine[Not[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]]]]
	,
	List[List[List[2000, 1, 1], False], List[List[2010, 1, 1], True]]	
	,
	TestID->"51d5dc88-83c5-4d44-a825-cf659d889065"
]

VerificationTest[(* 42 *)
	ShowTimeLine[Or[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], RuleStub[]]]
	,
	List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], RuleStub[]]]	
	,
	TestID->"d27d7749-0359-4788-9986-43ef471f5e34"
]

VerificationTest[(* 43 *)
	ShowTimeLine[Not[T[List[List[DawnOfTime, True]]]]]
	,
	False	
	,
	TestID->"9537c8bd-ae5a-46f3-8a5f-074113e487d5"
]

VerificationTest[(* 44 *)
	Not[RuleStub[]]
	,
	RuleStub[]	
	,
	TestID->"1eca99b7-87bf-48ea-89aa-03c62d123f5f"
]

VerificationTest[(* 45 *)
	Not[Uncertain[]]
	,
	Uncertain[]	
	,
	TestID->"07c312a7-e08a-47c1-8917-ba3b53d34708"
]

EndTestSection[]

BeginTestSection["Constructing Boolean TimeLines"]

VerificationTest[(* 46 *)
	ShowTimeLine[TrueOnOrAfter[List[2017, 2, 2]]]
	,
	List[List[DawnOfTime, False], List[List[2017, 2, 2], True]]	
	,
	TestID->"119ab0da-6849-407f-8a9f-1faf41e8a7fd"
]

VerificationTest[(* 47 *)
	ShowTimeLine[TrueOnOrAfter[DawnOfTime]]
	,
	True	
	,
	TestID->"753bdcad-8583-4d87-b1cf-6a15540f54df"
]

VerificationTest[(* 48 *)
	ShowTimeLine[TrueBefore[List[2017, 2, 2]]]
	,
	List[List[DawnOfTime, True], List[List[2017, 2, 2], False]]	
	,
	TestID->"3506f3a4-0653-40ca-a40d-8b6efd81d584"
]

VerificationTest[(* 49 *)
	ShowTimeLine[TrueBefore[DawnOfTime]]
	,
	False	
	,
	TestID->"747d92f5-f251-4fef-87c1-b04381e8ac5f"
]

VerificationTest[(* 50 *)
	ShowTimeLine[TrueBetween[List[2017, 2, 2], List[2020, 7, 7]]]
	,
	List[List[DawnOfTime, False], List[List[2017, 2, 2], True], List[List[2020, 7, 7], False]]	
	,
	TestID->"1228a6b0-8f47-463b-9830-da58906f97d9"
]

VerificationTest[(* 51 *)
	ShowTimeLine[TrueBetween[DawnOfTime, List[2020, 7, 7]]]
	,
	List[List[DawnOfTime, True], List[List[2020, 7, 7], False]]	
	,
	TestID->"903a3d0d-eef5-473e-9861-2cae75c1cd7d"
]

EndTestSection[]

BeginTestSection["Ever or Always True"]

VerificationTest[(* 52 *)
	EverQ[True]
	,
	True	
	,
	TestID->"643b5c13-ea3a-4506-a410-5b2506000332"
]

VerificationTest[(* 53 *)
	EverQ[False]
	,
	False	
	,
	TestID->"b60b438f-bc44-4732-8167-c1fc7e21f793"
]

VerificationTest[(* 54 *)
	EverQ[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]]]
	,
	True	
	,
	TestID->"e9159525-699c-4dca-a17d-b6585bc06ebe"
]

VerificationTest[(* 55 *)
	EverQ[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], False]
	,
	True	
	,
	TestID->"7756c348-37f6-4c27-8d08-40da59cad018"
]

VerificationTest[(* 56 *)
	AlwaysQ[True]
	,
	True	
	,
	TestID->"6a01a9cf-6093-45a7-bfad-b4895acb6001"
]

VerificationTest[(* 57 *)
	AlwaysQ[False]
	,
	False	
	,
	TestID->"bd72bfe9-f68f-403c-9ea3-d0a9bd76dac2"
]

VerificationTest[(* 58 *)
	AlwaysQ[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]]]
	,
	False	
	,
	TestID->"0158097b-cf4d-40e5-8033-fd8735ac81ef"
]

VerificationTest[(* 59 *)
	AlwaysQ[7, 7]
	,
	True	
	,
	TestID->"47559451-5ee6-4c28-b2ac-46fd7af56d2c"
]

EndTestSection[]

BeginTestSection["When Next or Last True"]

EndTestSection[]

EndTestSection[]

BeginTestSection["Conditionals"]

BeginTestSection["InternalIf"]

VerificationTest[(* 60 *)
	ShowTimeLine[InternalIf[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], 1, 0]]
	,
	List[List[List[2000, 1, 1], 1], List[List[2010, 1, 1], 0]]	
	,
	TestID->"9634baac-aece-4875-92d2-e2e30322b192"
]

VerificationTest[(* 61 *)
	ShowTimeLine[InternalIf[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], T[List[List[DawnOfTime, True], List[List[2020, 1, 1], False]]], 0]]
	,
	List[List[DawnOfTime, True], List[List[2010, 1, 1], 0]]	
	,
	TestID->"788e3981-08c0-4a99-a951-ceb8534c8e80"
]

VerificationTest[(* 62 *)
	ShowTimeLine[InternalIf[True, T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], False]]
	,
	List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]	
	,
	TestID->"888941dd-97ee-4470-bd56-e4bccb85c476"
]

VerificationTest[(* 63 *)
	ShowTimeLine[InternalIf[False, T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], False]]
	,
	False	
	,
	TestID->"8779f9e5-0f85-4920-8047-14275ae4e27a"
]

VerificationTest[(* 64 *)
	ShowTimeLine[InternalIf[T[List[List[List[2000, 1, 1], True], List[List[2010, 1, 1], False]]], T[List[List[DawnOfTime, True], List[List[2020, 1, 1], False]]], T[List[List[DawnOfTime, RuleStub[]], List[List[2015, 1, 1], Uncertain[]]]]]]
	,
	List[List[DawnOfTime, True], List[List[2010, 1, 1], RuleStub[]], List[List[2015, 1, 1], Uncertain[]]]	
	,
	TestID->"ea95eec7-4afe-419d-abcd-924cfd1311c0"
]

(* ::Text:: *)
(*Unit tests for recursive time series functions:*)

VerificationTest[(* 65 *)
	ShowTimeLine[fib[T[List[List[List[2000, 1, 1], 8], List[List[2010, 1, 1], 9]]]]]
	,
	List[List[List[2000, 1, 1], 21], List[List[2010, 1, 1], 34]]	
	,
	TestID->"34b3b9a6-2a47-403c-9e4a-f7e65fe409b3"
]

VerificationTest[(* 66 *)
	ShowTimeLine[fib[T[List[List[List[2000, 1, 1], RuleStub[]], List[List[2010, 1, 1], 9]]]]]
	,
	List[List[List[2000, 1, 1], RuleStub[]], List[List[2010, 1, 1], 34]]	
	,
	TestID->"d88db481-c88e-4925-9e13-796e5c729c42"
]

VerificationTest[(* 67 *)
	fib[Uncertain[]]
	,
	Uncertain[]	
	,
	TestID->"ab4fd64b-98c7-4126-99a5-c5f4d09b2945"
]

EndTestSection[]

BeginTestSection["IfThen"]

VerificationTest[(* 68 *)
	IfThen[True, 8, 9]
	,
	8	
	,
	TestID->"e9143387-9148-4c98-8b57-6041db845bb3"
]

VerificationTest[(* 69 *)
	IfThen[False, 8, 9]
	,
	9	
	,
	TestID->"639556a9-66b4-4979-bf33-a5040e687600"
]

VerificationTest[(* 70 *)
	IfThen[False, 8, False, 9, 10]
	,
	10	
	,
	TestID->"d1343dd1-4d6e-4343-b79c-cc661b55a5a0"
]

VerificationTest[(* 71 *)
	ShowTimeLine[IfThen[TrueOnOrAfter[List[1996, 4, 4]], 42, 43]]
	,
	List[List[DawnOfTime, 43], List[List[1996, 4, 4], 42]]	
	,
	TestID->"35cba894-0da3-4b69-9d54-ca3f4a9eba2a"
]

VerificationTest[(* 72 *)
	ShowTimeLine[IfThen[TrueOnOrAfter[List[1996, 4, 4]], 42, TrueOnOrAfter[List[1993, 4, 4]], 43, 44]]
	,
	List[List[DawnOfTime, 44], List[List[1993, 4, 4], 43], List[List[1996, 4, 4], 42]]	
	,
	TestID->"bcb5ed5d-09bc-4784-a1cf-471ac0f92b71"
]

(* ::Text:: *)
(*Recursion tests:*)

VerificationTest[(* 73 *)
	ShowTimeLine[fib2[T[List[List[List[2000, 1, 1], 10], List[List[2010, 1, 1], 9]]]]]
	,
	List[List[List[2000, 1, 1], 55], List[List[2010, 1, 1], 34]]	
	,
	TestID->"890f03bc-6f28-46b3-8046-a0b3d3a57b21"
]

EndTestSection[]

BeginTestSection["SwitchThen"]

VerificationTest[(* 74 *)
	Equal[SwitchThen["a", "a", 1, "b", 2, "default"], Switch["a", "a", 1, "b", 2], 1]
	,
	True	
	,
	TestID->"fafd595b-b1cd-4d93-832d-879de2cdb7d4"
]

VerificationTest[(* 75 *)
	Equal[SwitchThen["b", "a", 1, "b", 2, "default"], Switch["b", "a", 1, "b", 2], 2]
	,
	True	
	,
	TestID->"df15d38c-cf8d-43ca-be8c-63dc101f59b4"
]

VerificationTest[(* 76 *)
	SwitchThen["c", "a", 1, "b", 2, "default"]
	,
	"default"	
	,
	TestID->"d556b804-af21-4e02-8b97-5f6d2a796431"
]

VerificationTest[(* 77 *)
	ShowTimeLine[SwitchThen[TrueOnOrAfter[List[1996, 4, 4]], True, 1, False, 2, "default"]]
	,
	List[List[DawnOfTime, 2], List[List[1996, 4, 4], 1]]	
	,
	TestID->"1d40c9c9-83ff-4d8f-bb37-950e7c267287"
]

VerificationTest[(* 78 *)
	ShowTimeLine[SwitchThen[TrueOnOrAfter[List[1996, 4, 4]], False, 1, True, 2, "default"]]
	,
	List[List[DawnOfTime, 1], List[List[1996, 4, 4], 2]]	
	,
	TestID->"dc171333-14dc-46f4-8a60-79e12679b0a1"
]

(* ::Text:: *)
(*Here the issue is the comparison of different types.  Need to overload the === operator?*)

VerificationTest[(* 79 *)
	ShowTimeLine[SwitchThen[True, "a", 1, TrueOnOrAfter[List[1996, 4, 4]], 2, "default"]]
	,
	List[List[DawnOfTime, "default"], List[List[1996, 4, 4], 2]]	
	,
	TestID->"204aee46-c83b-4ad8-a818-3e23f66a775b"
]

(* ::Text:: *)
(*Tests where the switch expression is a list:*)

VerificationTest[(* 80 *)
	SwitchThen[List[1, 2], List[1, 2], "a", List[2, 3], "b", "default"]
	,
	"a"	
	,
	TestID->"b4a48c6d-3585-4aad-9aa2-d92f7c50648e"
]

VerificationTest[(* 81 *)
	SwitchThen[List[1, 4], List[1, 2], "a", List[2, 3], "b", "default"]
	,
	"default"	
	,
	TestID->"0563dcdd-2fca-473c-b786-877736ef7d03"
]

VerificationTest[(* 82 *)
	SwitchThen[List[2, 3], List[1, 2], "a", List[2, 3], "b", "default"]
	,
	"b"	
	,
	TestID->"13cf5ef2-82e7-4dce-96aa-4117f3df02d1"
]

VerificationTest[(* 83 *)
	SwitchThen[List[], List[1, 2], "a", List[2, 3], "b", "default"]
	,
	"default"	
	,
	TestID->"f4a8ba50-5a0c-42cf-8572-2f9a41ab236f"
]

EndTestSection[]

EndTestSection[]

BeginTestSection["Arithmetic"]

BeginTestSection["Addition & Subtraction"]

VerificationTest[(* 84 *)
	ShowTimeLine[Plus[T[List[List[List[1, 1, 1], 1], List[List[2010, 1, 1], 0]]], T[List[List[List[1, 1, 1], 22], List[List[2010, 1, 1], 33]]]]]
	,
	List[List[List[1, 1, 1], 23], List[List[2010, 1, 1], 33]]	
	,
	TestID->"006099f3-3cc9-45f6-a5f5-4573a003ed1a"
]

VerificationTest[(* 85 *)
	plus[Uncertain[], T[List[List[List[1, 1, 1], 1], List[List[2010, 1, 1], 0]]]]
	,
	Uncertain[]	
	,
	TestID->"0f664b1b-65e7-49c7-af2d-010e0fad3daf"
]

VerificationTest[(* 86 *)
	Plus[7, Uncertain[]]
	,
	Uncertain[]	
	,
	TestID->"a8cf3de8-2bbd-4a9b-aca3-66a1094ebdec"
]

VerificationTest[(* 87 *)
	Plus[T[List[List[List[1, 1, 1], 1], List[List[2010, 1, 1], 0]]], RuleStub[]]
	,
	RuleStub[]	
	,
	TestID->"58d1f694-d9a9-454d-8b3e-8603e0054ca7"
]

VerificationTest[(* 88 *)
	ShowTimeLine[Plus[44, T[List[List[List[1, 1, 1], 1], List[List[2010, 1, 1], 0]]]]]
	,
	List[List[List[1, 1, 1], 45], List[List[2010, 1, 1], 44]]	
	,
	TestID->"a2b7dfbd-3bce-47e9-a7f7-f6413845796b"
]

VerificationTest[(* 89 *)
	ShowTimeLine[Plus[44, T[List[List[List[1, 1, 1], 1], List[List[2010, 1, 1], 0]]], -71]]
	,
	List[List[List[1, 1, 1], -26], List[List[2010, 1, 1], -27]]	
	,
	TestID->"327c6d2f-77cb-4282-84ac-7d32b72c56fb"
]

VerificationTest[(* 90 *)
	ShowTimeLine[Plus[44, T[List[List[List[1, 1, 1], RuleStub[]], List[List[2010, 1, 1], 0]]]]]
	,
	List[List[List[1, 1, 1], RuleStub[]], List[List[2010, 1, 1], 44]]	
	,
	TestID->"16e47c5c-0ef2-4a38-80db-9e09f9079de8"
]

EndTestSection[]

BeginTestSection["Multiplication"]

VerificationTest[(* 91 *)
	ShowTimeLine[Times[T[List[List[List[1, 1, 1], 1], List[List[2010, 1, 1], 0]]], RuleStub[]]]
	,
	List[List[List[1, 1, 1], RuleStub[]], List[List[2010, 1, 1], 0]]	
	,
	TestID->"1ab6d469-37e0-4e7f-aee7-d945aa8e871b"
]

VerificationTest[(* 92 *)
	Times[T[List[List[List[1, 1, 1], 1], List[List[2010, 1, 1], 0]]], 0]
	,
	0	
	,
	TestID->"08b07a20-77b5-45b6-bf07-94e47d1b60d2"
]

VerificationTest[(* 93 *)
	Times[0, RuleStub[]]
	,
	0	
	,
	TestID->"6096f1d9-a163-43a2-ba63-251d7257aac3"
]

VerificationTest[(* 94 *)
	ShowTimeLine[Times[T[List[List[List[1, 1, 1], 1], List[List[2010, 1, 1], 10]]], T[List[List[List[1, 1, 1], 2], List[List[2015, 1, 1], 20]]]]]
	,
	List[List[List[1, 1, 1], 2], List[List[2010, 1, 1], 20], List[List[2015, 1, 1], 200]]	
	,
	TestID->"6c02d327-f957-4e1c-bf82-49bc2d7cd568"
]

VerificationTest[(* 95 *)
	ShowTimeLine[Times[T[List[List[List[1, 1, 1], Uncertain[]], List[List[2010, 1, 1], 10]]], T[List[List[List[1, 1, 1], RuleStub[]], List[List[2015, 1, 1], 20]]]]]
	,
	List[List[List[1, 1, 1], RuleStub[]], List[List[2015, 1, 1], 200]]	
	,
	TestID->"dc264673-0777-4ae9-a1ef-f27892a5470d"
]

VerificationTest[(* 96 *)
	ShowTimeLine[Times[-7, T[List[List[List[1, 1, 1], 14], List[List[2015, 1, 1], 20]]]]]
	,
	List[List[List[1, 1, 1], -98], List[List[2015, 1, 1], -140]]	
	,
	TestID->"eec2b17b-3283-4d16-b452-be19fb31279b"
]

EndTestSection[]

BeginTestSection["Division"]

VerificationTest[(* 97 *)
	ShowTimeLine[Times[T[List[List[List[1, 1, 1], 14], List[List[2015, 1, 1], 20]]], Power[2, -1]]]
	,
	List[List[List[1, 1, 1], 7], List[List[2015, 1, 1], 10]]	
	,
	TestID->"07ed8e09-52b1-43a1-8ba0-991f0703b29b"
]

VerificationTest[(* 98 *)
	ShowTimeLine[Times[40, Power[T[List[List[List[1, 1, 1], 10], List[List[2015, 1, 1], 20]]], -1]]]
	,
	List[List[List[1, 1, 1], 4], List[List[2015, 1, 1], 2]]	
	,
	TestID->"86cc3530-a545-4b8c-a770-d0c4f4c56793"
]

VerificationTest[(* 99 *)
	Times[T[List[List[List[1, 1, 1], 14], List[List[2015, 1, 1], 20]]], Power[Uncertain[], -1]]
	,
	Uncertain[]	
	,
	TestID->"60915a1d-0076-40ed-93e2-d8d33e3e3d8d"
]

VerificationTest[(* 100 *)
	ShowTimeLine[Times[T[List[List[List[1, 1, 1], Uncertain[]], List[List[2015, 1, 1], 20]]], Power[2, -1]]]
	,
	List[List[List[1, 1, 1], Uncertain[]], List[List[2015, 1, 1], 10]]	
	,
	TestID->"a1d0f856-f034-4073-bfd5-b36a7955faf4"
]

VerificationTest[(* 101 *)
	ShowTimeLine[Times[40, Power[T[List[List[List[1, 1, 1], 10], List[List[2015, 1, 1], RuleStub[]]]], -1]]]
	,
	List[List[List[1, 1, 1], 4], List[List[2015, 1, 1], RuleStub[]]]	
	,
	TestID->"a1d0f856-f334-4073-bfd5-b36a7955faf4"
]

EndTestSection[]

BeginTestSection["Numeric"]

VerificationTest[(* 102 *)
	ShowTimeLine[Numeric[T[List[List[List[1, 1, 1], Times[3, Power[2, -1]]], List[List[2015, 1, 1], Times[1, Power[3, -1]]]]]]]
	,
	List[List[List[1, 1, 1], 1.5`], List[List[2015, 1, 1], 0.3333333333333333`]]	
	,
	TestID->"857313d4-2831-4f07-83fc-64aa72fc6ed3"
]

VerificationTest[(* 103 *)
	ShowTimeLine[Numeric[T[List[List[List[1, 1, 1], Times[3, Power[2, -1]]], List[List[2015, 1, 1], Times[1, Power[3, -1]]]]]]]
	,
	List[List[List[1, 1, 1], 1.5`], List[List[2015, 1, 1], 0.3333333333333333`]]	
	,
	TestID->"f590b4c2-f756-4907-8bfa-f37293169542"
]

VerificationTest[(* 104 *)
	Numeric[7]
	,
	7.`	
	,
	TestID->"bdc08b4e-1d92-4062-bd0a-36f5814d86d6"
]

EndTestSection[]

BeginTestSection["Modulo"]

VerificationTest[(* 105 *)
	AsOf[List[2025, 3, 3], Modulo[theYear, 10]]
	,
	5	
	,
	TestID->"21d66d4b-9047-4a7c-b8e8-62f55436a39a"
]

EndTestSection[]

BeginTestSection["Rounding"]

VerificationTest[(* 106 *)
	ShowTimeLine[Round[theYear, 9]]
	,
	List[List[List[2000, 1, 1], 1998], List[List[2003, 1, 1], 2007], List[List[2012, 1, 1], 2016], List[List[2021, 1, 1], 2025], List[List[2030, 1, 1], 2034], List[List[2039, 1, 1], 2043], List[List[2048, 1, 1], 2052]]	
	,
	TestID->"559d3019-bdaf-478d-be5e-f62c1a2c3955"
]

VerificationTest[(* 107 *)
	ShowTimeLine[Ceiling[theYear, 20]]
	,
	List[List[List[2000, 1, 1], 2000], List[List[2001, 1, 1], 2020], List[List[2021, 1, 1], 2040], List[List[2041, 1, 1], 2060]]	
	,
	TestID->"e29d3019-baaf-478d-be5e-f62c1a2c390c"
]

VerificationTest[(* 108 *)
	ShowTimeLine[Floor[theYear, 7]]
	,
	List[List[List[2000, 1, 1], 1995], List[List[2002, 1, 1], 2002], List[List[2009, 1, 1], 2009], List[List[2016, 1, 1], 2016], List[List[2023, 1, 1], 2023], List[List[2030, 1, 1], 2030], List[List[2037, 1, 1], 2037], List[List[2044, 1, 1], 2044]]	
	,
	TestID->"135e067f-4412-4d90-a8ce-643721eb44c4"
]

EndTestSection[]

EndTestSection[]

BeginTestSection["Comparison"]

BeginTestSection["Comparison"]

VerificationTest[(* 109 *)
	GreaterEqual[T[List[List[List[2000, 1, 1], 4], List[List[2010, 1, 1], 3]]], RuleStub[]]
	,
	RuleStub[]	
	,
	TestID->"650225d6-0699-459a-a3e2-37b73b31ddd2"
]

VerificationTest[(* 110 *)
	ShowTimeLine[GreaterEqual[T[List[List[List[2000, 1, 1], 4], List[List[2010, 1, 1], 3]]], T[List[List[List[2000, 1, 1], 6], List[List[2020, 1, 1], 2]]]]]
	,
	List[List[List[2000, 1, 1], False], List[List[2020, 1, 1], True]]	
	,
	TestID->"22dc15c4-0de5-457e-bfee-c54e01815789"
]

VerificationTest[(* 111 *)
	Equal[8, T[List[List[List[2000, 1, 1], 4], List[List[2010, 1, 1], 3]]]]
	,
	False	
	,
	TestID->"0746d01f-9618-47ee-a998-75ce6e3493fd"
]

VerificationTest[(* 112 *)
	ShowTimeLine[Equal[8, T[List[List[List[2000, 1, 1], 4], List[List[2010, 1, 1], 8]]]]]
	,
	List[List[List[2000, 1, 1], False], List[List[2010, 1, 1], True]]	
	,
	TestID->"4713f2ef-3c57-4256-9454-1666c3ec6d0b"
]

VerificationTest[(* 113 *)
	ShowTimeLine[Less[T[List[List[List[2000, 1, 1], 4], List[List[2010, 1, 1], 3]]], T[List[List[List[2000, 1, 1], RuleStub[]], List[List[2020, 1, 1], 2]]]]]
	,
	List[List[List[2000, 1, 1], RuleStub[]], List[List[2020, 1, 1], False]]	
	,
	TestID->"0e6b98fd-d7ed-41f0-912e-bad825f2d31c"
]

VerificationTest[(* 114 *)
	ShowTimeLine[Unequal[Uncertain[], T[List[List[List[2000, 1, 1], RuleStub[]], List[List[2020, 1, 1], 2]]]]]
	,
	List[List[List[2000, 1, 1], RuleStub[]], List[List[2020, 1, 1], Uncertain[]]]	
	,
	TestID->"a84e70ed-86a2-477b-8954-a45a97129979"
]

VerificationTest[(* 115 *)
	ShowTimeLine[Less[T[List[List[List[2000, 1, 1], 4], List[List[2010, 1, 1], 3]]], T[List[List[List[2003, 1, 1], 5], List[List[2020, 1, 1], 2]]]]]
	,
	List[List[List[2000, 1, 1], True], List[List[2020, 1, 1], False]]	
	,
	TestID->"f7508d5a-1786-419b-9709-872366ea35d3"
]

VerificationTest[(* 116 *)
	Equal[T[List[List[List[1, 1, 1], 4]]], 9]
	,
	False	
	,
	TestID->"6a0eeef5-919e-4288-b606-6c41e80a153b"
]

EndTestSection[]

EndTestSection[]

BeginTestSection["Date Operations"]

BeginTestSection["Composition"]

EndTestSection[]

BeginTestSection["Decomposition"]

EndTestSection[]

BeginTestSection["Differences Between Dates"]

VerificationTest[(* 117 *)
	ShowTimeLine[DayDiff[List[2000, 1, 1], TimeLineWindow[theDate, List[2017, 1, 1], List[2017, 1, 4]]]]
	,
	List[List[List[2017, 1, 1], 6210], List[List[2017, 1, 2], 6211], List[List[2017, 1, 3], 6212]]	
	,
	TestID->"1867478d-3377-40f6-82de-767adf99ce16"
]

VerificationTest[(* 118 *)
	ShowTimeLine[YearDiff[List[2015, 2, 2], TimeLineWindow[theDate, List[2017, 1, 1], List[2017, 1, 4]]]]
	,
	List[List[List[2017, 1, 1], 1.9125683060109289`], List[List[2017, 1, 2], 1.9153005464480874`], List[List[2017, 1, 3], 1.9180327868852458`]]	
	,
	TestID->"3708b48f-b35a-48a6-a03d-92d03bf63502"
]

EndTestSection[]

EndTestSection[]

BeginTestSection["List Operations"]

BeginTestSection["Length"]

EndTestSection[]

BeginTestSection["Minimum & Maximum"]

VerificationTest[(* 119 *)
	ShowTimeLine[Minimum[T[List[List[DawnOfTime, List[1, 3, 4, 5]], List[List[2017, 8, 8], List[3, 4, 5, 6, 7, 8]]]]]]
	,
	List[List[List[2000, 1, 1], 1], List[List[2017, 8, 8], 3]]	
	,
	TestID->"729f43f1-b5ae-4e37-89a2-dbd5a7451baf"
]

VerificationTest[(* 120 *)
	Minimum[Uncertain[]]
	,
	Uncertain[]	
	,
	TestID->"ca0e334c-6ba2-47ca-84db-3403c27650d8"
]

EndTestSection[]

EndTestSection[]

BeginTestSection["Interval Count Relative to a Point in Time"]

BeginTestSection["YearsSince"]

EndTestSection[]

BeginTestSection["DaysSince"]

EndTestSection[]

BeginTestSection["MonthsSince"]

EndTestSection[]

BeginTestSection["WeeksSince"]

EndTestSection[]

BeginTestSection["IntervalsSince"]

EndTestSection[]

EndTestSection[]

BeginTestSection["Absolute Time"]

BeginTestSection["Internal Machinery"]

EndTestSection[]

BeginTestSection["Calendar-Based TimeLines"]

EndTestSection[]

BeginTestSection["Interval Ratios"]

EndTestSection[]

BeginTestSection["First/Last Day of Interval"]

EndTestSection[]

BeginTestSection["Weekdays"]

EndTestSection[]

EndTestSection[]

BeginTestSection["Per Interval"]

EndTestSection[]

BeginTestSection["Elapsed Time"]

EndTestSection[]

BeginTestSection["Miscellaneous"]

EndTestSection[]

BeginTestSection["Temporal Aggregations"]

EndTestSection[]

EndTestSection[]

BeginTestSection["Proof Trees"]

BeginTestSection["Proof Trees"]

EndTestSection[]

EndTestSection[]

EndTestSection[]

EndTestSection[]
