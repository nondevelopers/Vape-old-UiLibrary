local lib = {RainbowColorValue = 0, HueSelectionPosition = 0}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local PresetColor = Color3.fromRGB(44, 120, 224)
local CloseBind = Enum.KeyCode.RightControl

-- Lucide icon lookup: each entry is one Lucide icon (https://lucide.dev)
-- pre-uploaded to Roblox as its own single-image asset - no sprite sheet
-- math needed, just look up the name and use the id directly as an
-- ImageLabel's Image. Data sourced from the MIT-licensed lucide-roblox
-- project via Fluent's Icons.lua:
-- https://github.com/dawid-scripts/Fluent/blob/master/src/Icons.lua
local LucideIcons = {
    ["accessibility"] = "rbxassetid://10709751939",
    ["activity"] = "rbxassetid://10709752035",
    ["air-vent"] = "rbxassetid://10709752131",
    ["airplay"] = "rbxassetid://10709752254",
    ["alarm-check"] = "rbxassetid://10709752405",
    ["alarm-clock"] = "rbxassetid://10709752630",
    ["alarm-clock-off"] = "rbxassetid://10709752508",
    ["alarm-minus"] = "rbxassetid://10709752732",
    ["alarm-plus"] = "rbxassetid://10709752825",
    ["album"] = "rbxassetid://10709752906",
    ["alert-circle"] = "rbxassetid://10709752996",
    ["alert-octagon"] = "rbxassetid://10709753064",
    ["alert-triangle"] = "rbxassetid://10709753149",
    ["align-center"] = "rbxassetid://10709753570",
    ["align-center-horizontal"] = "rbxassetid://10709753272",
    ["align-center-vertical"] = "rbxassetid://10709753421",
    ["align-end-horizontal"] = "rbxassetid://10709753692",
    ["align-end-vertical"] = "rbxassetid://10709753808",
    ["align-horizontal-distribute-center"] = "rbxassetid://10747779791",
    ["align-horizontal-distribute-end"] = "rbxassetid://10747784534",
    ["align-horizontal-distribute-start"] = "rbxassetid://10709754118",
    ["align-horizontal-justify-center"] = "rbxassetid://10709754204",
    ["align-horizontal-justify-end"] = "rbxassetid://10709754317",
    ["align-horizontal-justify-start"] = "rbxassetid://10709754436",
    ["align-horizontal-space-around"] = "rbxassetid://10709754590",
    ["align-horizontal-space-between"] = "rbxassetid://10709754749",
    ["align-justify"] = "rbxassetid://10709759610",
    ["align-left"] = "rbxassetid://10709759764",
    ["align-right"] = "rbxassetid://10709759895",
    ["align-start-horizontal"] = "rbxassetid://10709760051",
    ["align-start-vertical"] = "rbxassetid://10709760244",
    ["align-vertical-distribute-center"] = "rbxassetid://10709760351",
    ["align-vertical-distribute-end"] = "rbxassetid://10709760434",
    ["align-vertical-distribute-start"] = "rbxassetid://10709760612",
    ["align-vertical-justify-center"] = "rbxassetid://10709760814",
    ["align-vertical-justify-end"] = "rbxassetid://10709761003",
    ["align-vertical-justify-start"] = "rbxassetid://10709761176",
    ["align-vertical-space-around"] = "rbxassetid://10709761324",
    ["align-vertical-space-between"] = "rbxassetid://10709761434",
    ["anchor"] = "rbxassetid://10709761530",
    ["angry"] = "rbxassetid://10709761629",
    ["annoyed"] = "rbxassetid://10709761722",
    ["aperture"] = "rbxassetid://10709761813",
    ["apple"] = "rbxassetid://10709761889",
    ["archive"] = "rbxassetid://10709762233",
    ["archive-restore"] = "rbxassetid://10709762058",
    ["armchair"] = "rbxassetid://10709762327",
    ["arrow-big-down"] = "rbxassetid://10747796644",
    ["arrow-big-left"] = "rbxassetid://10709762574",
    ["arrow-big-right"] = "rbxassetid://10709762727",
    ["arrow-big-up"] = "rbxassetid://10709762879",
    ["arrow-down"] = "rbxassetid://10709767827",
    ["arrow-down-circle"] = "rbxassetid://10709763034",
    ["arrow-down-left"] = "rbxassetid://10709767656",
    ["arrow-down-right"] = "rbxassetid://10709767750",
    ["arrow-left"] = "rbxassetid://10709768114",
    ["arrow-left-circle"] = "rbxassetid://10709767936",
    ["arrow-left-right"] = "rbxassetid://10709768019",
    ["arrow-right"] = "rbxassetid://10709768347",
    ["arrow-right-circle"] = "rbxassetid://10709768226",
    ["arrow-up"] = "rbxassetid://10709768939",
    ["arrow-up-circle"] = "rbxassetid://10709768432",
    ["arrow-up-down"] = "rbxassetid://10709768538",
    ["arrow-up-left"] = "rbxassetid://10709768661",
    ["arrow-up-right"] = "rbxassetid://10709768787",
    ["asterisk"] = "rbxassetid://10709769095",
    ["at-sign"] = "rbxassetid://10709769286",
    ["award"] = "rbxassetid://10709769406",
    ["axe"] = "rbxassetid://10709769508",
    ["axis-3d"] = "rbxassetid://10709769598",
    ["baby"] = "rbxassetid://10709769732",
    ["backpack"] = "rbxassetid://10709769841",
    ["baggage-claim"] = "rbxassetid://10709769935",
    ["banana"] = "rbxassetid://10709770005",
    ["banknote"] = "rbxassetid://10709770178",
    ["bar-chart"] = "rbxassetid://10709773755",
    ["bar-chart-2"] = "rbxassetid://10709770317",
    ["bar-chart-3"] = "rbxassetid://10709770431",
    ["bar-chart-4"] = "rbxassetid://10709770560",
    ["bar-chart-horizontal"] = "rbxassetid://10709773669",
    ["barcode"] = "rbxassetid://10747360675",
    ["baseline"] = "rbxassetid://10709773863",
    ["bath"] = "rbxassetid://10709773963",
    ["battery"] = "rbxassetid://10709774640",
    ["battery-charging"] = "rbxassetid://10709774068",
    ["battery-full"] = "rbxassetid://10709774206",
    ["battery-low"] = "rbxassetid://10709774370",
    ["battery-medium"] = "rbxassetid://10709774513",
    ["beaker"] = "rbxassetid://10709774756",
    ["bed"] = "rbxassetid://10709775036",
    ["bed-double"] = "rbxassetid://10709774864",
    ["bed-single"] = "rbxassetid://10709774968",
    ["beer"] = "rbxassetid://10709775167",
    ["bell"] = "rbxassetid://10709775704",
    ["bell-minus"] = "rbxassetid://10709775241",
    ["bell-off"] = "rbxassetid://10709775320",
    ["bell-plus"] = "rbxassetid://10709775448",
    ["bell-ring"] = "rbxassetid://10709775560",
    ["bike"] = "rbxassetid://10709775894",
    ["binary"] = "rbxassetid://10709776050",
    ["bitcoin"] = "rbxassetid://10709776126",
    ["bluetooth"] = "rbxassetid://10709776655",
    ["bluetooth-connected"] = "rbxassetid://10709776240",
    ["bluetooth-off"] = "rbxassetid://10709776344",
    ["bluetooth-searching"] = "rbxassetid://10709776501",
    ["bold"] = "rbxassetid://10747813908",
    ["bomb"] = "rbxassetid://10709781460",
    ["bone"] = "rbxassetid://10709781605",
    ["book"] = "rbxassetid://10709781824",
    ["book-open"] = "rbxassetid://10709781717",
    ["bookmark"] = "rbxassetid://10709782154",
    ["bookmark-minus"] = "rbxassetid://10709781919",
    ["bookmark-plus"] = "rbxassetid://10709782044",
    ["bot"] = "rbxassetid://10709782230",
    ["box"] = "rbxassetid://10709782497",
    ["box-select"] = "rbxassetid://10709782342",
    ["boxes"] = "rbxassetid://10709782582",
    ["briefcase"] = "rbxassetid://10709782662",
    ["brush"] = "rbxassetid://10709782758",
    ["bug"] = "rbxassetid://10709782845",
    ["building"] = "rbxassetid://10709783051",
    ["building-2"] = "rbxassetid://10709782939",
    ["bus"] = "rbxassetid://10709783137",
    ["cake"] = "rbxassetid://10709783217",
    ["calculator"] = "rbxassetid://10709783311",
    ["calendar"] = "rbxassetid://10709789505",
    ["calendar-check"] = "rbxassetid://10709783474",
    ["calendar-check-2"] = "rbxassetid://10709783392",
    ["calendar-clock"] = "rbxassetid://10709783577",
    ["calendar-days"] = "rbxassetid://10709783673",
    ["calendar-heart"] = "rbxassetid://10709783835",
    ["calendar-minus"] = "rbxassetid://10709783959",
    ["calendar-off"] = "rbxassetid://10709788784",
    ["calendar-plus"] = "rbxassetid://10709788937",
    ["calendar-range"] = "rbxassetid://10709789053",
    ["calendar-search"] = "rbxassetid://10709789200",
    ["calendar-x"] = "rbxassetid://10709789407",
    ["calendar-x-2"] = "rbxassetid://10709789329",
    ["camera"] = "rbxassetid://10709789686",
    ["camera-off"] = "rbxassetid://10747822677",
    ["car"] = "rbxassetid://10709789810",
    ["carrot"] = "rbxassetid://10709789960",
    ["cast"] = "rbxassetid://10709790097",
    ["charge"] = "rbxassetid://10709790202",
    ["check"] = "rbxassetid://10709790644",
    ["check-circle"] = "rbxassetid://10709790387",
    ["check-circle-2"] = "rbxassetid://10709790298",
    ["check-square"] = "rbxassetid://10709790537",
    ["chef-hat"] = "rbxassetid://10709790757",
    ["cherry"] = "rbxassetid://10709790875",
    ["chevron-down"] = "rbxassetid://10709790948",
    ["chevron-first"] = "rbxassetid://10709791015",
    ["chevron-last"] = "rbxassetid://10709791130",
    ["chevron-left"] = "rbxassetid://10709791281",
    ["chevron-right"] = "rbxassetid://10709791437",
    ["chevron-up"] = "rbxassetid://10709791523",
    ["chevrons-down"] = "rbxassetid://10709796864",
    ["chevrons-down-up"] = "rbxassetid://10709791632",
    ["chevrons-left"] = "rbxassetid://10709797151",
    ["chevrons-left-right"] = "rbxassetid://10709797006",
    ["chevrons-right"] = "rbxassetid://10709797382",
    ["chevrons-right-left"] = "rbxassetid://10709797274",
    ["chevrons-up"] = "rbxassetid://10709797622",
    ["chevrons-up-down"] = "rbxassetid://10709797508",
    ["chrome"] = "rbxassetid://10709797725",
    ["circle"] = "rbxassetid://10709798174",
    ["circle-dot"] = "rbxassetid://10709797837",
    ["circle-ellipsis"] = "rbxassetid://10709797985",
    ["circle-slashed"] = "rbxassetid://10709798100",
    ["citrus"] = "rbxassetid://10709798276",
    ["clapperboard"] = "rbxassetid://10709798350",
    ["clipboard"] = "rbxassetid://10709799288",
    ["clipboard-check"] = "rbxassetid://10709798443",
    ["clipboard-copy"] = "rbxassetid://10709798574",
    ["clipboard-edit"] = "rbxassetid://10709798682",
    ["clipboard-list"] = "rbxassetid://10709798792",
    ["clipboard-signature"] = "rbxassetid://10709798890",
    ["clipboard-type"] = "rbxassetid://10709798999",
    ["clipboard-x"] = "rbxassetid://10709799124",
    ["clock"] = "rbxassetid://10709805144",
    ["clock-1"] = "rbxassetid://10709799535",
    ["clock-10"] = "rbxassetid://10709799718",
    ["clock-11"] = "rbxassetid://10709799818",
    ["clock-12"] = "rbxassetid://10709799962",
    ["clock-2"] = "rbxassetid://10709803876",
    ["clock-3"] = "rbxassetid://10709803989",
    ["clock-4"] = "rbxassetid://10709804164",
    ["clock-5"] = "rbxassetid://10709804291",
    ["clock-6"] = "rbxassetid://10709804435",
    ["clock-7"] = "rbxassetid://10709804599",
    ["clock-8"] = "rbxassetid://10709804784",
    ["clock-9"] = "rbxassetid://10709804996",
    ["cloud"] = "rbxassetid://10709806740",
    ["cloud-cog"] = "rbxassetid://10709805262",
    ["cloud-drizzle"] = "rbxassetid://10709805371",
    ["cloud-fog"] = "rbxassetid://10709805477",
    ["cloud-hail"] = "rbxassetid://10709805596",
    ["cloud-lightning"] = "rbxassetid://10709805727",
    ["cloud-moon"] = "rbxassetid://10709805942",
    ["cloud-moon-rain"] = "rbxassetid://10709805838",
    ["cloud-off"] = "rbxassetid://10709806060",
    ["cloud-rain"] = "rbxassetid://10709806277",
    ["cloud-rain-wind"] = "rbxassetid://10709806166",
    ["cloud-snow"] = "rbxassetid://10709806374",
    ["cloud-sun"] = "rbxassetid://10709806631",
    ["cloud-sun-rain"] = "rbxassetid://10709806475",
    ["cloudy"] = "rbxassetid://10709806859",
    ["clover"] = "rbxassetid://10709806995",
    ["code"] = "rbxassetid://10709810463",
    ["code-2"] = "rbxassetid://10709807111",
    ["codepen"] = "rbxassetid://10709810534",
    ["codesandbox"] = "rbxassetid://10709810676",
    ["coffee"] = "rbxassetid://10709810814",
    ["cog"] = "rbxassetid://10709810948",
    ["coins"] = "rbxassetid://10709811110",
    ["columns"] = "rbxassetid://10709811261",
    ["command"] = "rbxassetid://10709811365",
    ["compass"] = "rbxassetid://10709811445",
    ["component"] = "rbxassetid://10709811595",
    ["concierge-bell"] = "rbxassetid://10709811706",
    ["connection"] = "rbxassetid://10747361219",
    ["contact"] = "rbxassetid://10709811834",
    ["contrast"] = "rbxassetid://10709811939",
    ["cookie"] = "rbxassetid://10709812067",
    ["copy"] = "rbxassetid://10709812159",
    ["copyleft"] = "rbxassetid://10709812251",
    ["copyright"] = "rbxassetid://10709812311",
    ["corner-down-left"] = "rbxassetid://10709812396",
    ["corner-down-right"] = "rbxassetid://10709812485",
    ["corner-left-down"] = "rbxassetid://10709812632",
    ["corner-left-up"] = "rbxassetid://10709812784",
    ["corner-right-down"] = "rbxassetid://10709812939",
    ["corner-right-up"] = "rbxassetid://10709813094",
    ["corner-up-left"] = "rbxassetid://10709813185",
    ["corner-up-right"] = "rbxassetid://10709813281",
    ["cpu"] = "rbxassetid://10709813383",
    ["croissant"] = "rbxassetid://10709818125",
    ["crop"] = "rbxassetid://10709818245",
    ["cross"] = "rbxassetid://10709818399",
    ["crosshair"] = "rbxassetid://10709818534",
    ["crown"] = "rbxassetid://10709818626",
    ["cup-soda"] = "rbxassetid://10709818763",
    ["curly-braces"] = "rbxassetid://10709818847",
    ["currency"] = "rbxassetid://10709818931",
    ["database"] = "rbxassetid://10709818996",
    ["delete"] = "rbxassetid://10709819059",
    ["diamond"] = "rbxassetid://10709819149",
    ["dice-1"] = "rbxassetid://10709819266",
    ["dice-2"] = "rbxassetid://10709819361",
    ["dice-3"] = "rbxassetid://10709819508",
    ["dice-4"] = "rbxassetid://10709819670",
    ["dice-5"] = "rbxassetid://10709819801",
    ["dice-6"] = "rbxassetid://10709819896",
    ["dices"] = "rbxassetid://10723343321",
    ["diff"] = "rbxassetid://10723343416",
    ["disc"] = "rbxassetid://10723343537",
    ["divide"] = "rbxassetid://10723343805",
    ["divide-circle"] = "rbxassetid://10723343636",
    ["divide-square"] = "rbxassetid://10723343737",
    ["dollar-sign"] = "rbxassetid://10723343958",
    ["download"] = "rbxassetid://10723344270",
    ["download-cloud"] = "rbxassetid://10723344088",
    ["droplet"] = "rbxassetid://10723344432",
    ["droplets"] = "rbxassetid://10734883356",
    ["drumstick"] = "rbxassetid://10723344737",
    ["edit"] = "rbxassetid://10734883598",
    ["edit-2"] = "rbxassetid://10723344885",
    ["edit-3"] = "rbxassetid://10723345088",
    ["egg"] = "rbxassetid://10723345518",
    ["egg-fried"] = "rbxassetid://10723345347",
    ["electricity"] = "rbxassetid://10723345749",
    ["electricity-off"] = "rbxassetid://10723345643",
    ["equal"] = "rbxassetid://10723345990",
    ["equal-not"] = "rbxassetid://10723345866",
    ["eraser"] = "rbxassetid://10723346158",
    ["euro"] = "rbxassetid://10723346372",
    ["expand"] = "rbxassetid://10723346553",
    ["external-link"] = "rbxassetid://10723346684",
    ["eye"] = "rbxassetid://10723346959",
    ["eye-off"] = "rbxassetid://10723346871",
    ["factory"] = "rbxassetid://10723347051",
    ["fan"] = "rbxassetid://10723354359",
    ["fast-forward"] = "rbxassetid://10723354521",
    ["feather"] = "rbxassetid://10723354671",
    ["figma"] = "rbxassetid://10723354801",
    ["file"] = "rbxassetid://10723374641",
    ["file-archive"] = "rbxassetid://10723354921",
    ["file-audio"] = "rbxassetid://10723355148",
    ["file-audio-2"] = "rbxassetid://10723355026",
    ["file-axis-3d"] = "rbxassetid://10723355272",
    ["file-badge"] = "rbxassetid://10723355622",
    ["file-badge-2"] = "rbxassetid://10723355451",
    ["file-bar-chart"] = "rbxassetid://10723355887",
    ["file-bar-chart-2"] = "rbxassetid://10723355746",
    ["file-box"] = "rbxassetid://10723355989",
    ["file-check"] = "rbxassetid://10723356210",
    ["file-check-2"] = "rbxassetid://10723356100",
    ["file-clock"] = "rbxassetid://10723356329",
    ["file-code"] = "rbxassetid://10723356507",
    ["file-cog"] = "rbxassetid://10723356830",
    ["file-cog-2"] = "rbxassetid://10723356676",
    ["file-diff"] = "rbxassetid://10723357039",
    ["file-digit"] = "rbxassetid://10723357151",
    ["file-down"] = "rbxassetid://10723357322",
    ["file-edit"] = "rbxassetid://10723357495",
    ["file-heart"] = "rbxassetid://10723357637",
    ["file-image"] = "rbxassetid://10723357790",
    ["file-input"] = "rbxassetid://10723357933",
    ["file-json"] = "rbxassetid://10723364435",
    ["file-json-2"] = "rbxassetid://10723364361",
    ["file-key"] = "rbxassetid://10723364605",
    ["file-key-2"] = "rbxassetid://10723364515",
    ["file-line-chart"] = "rbxassetid://10723364725",
    ["file-lock"] = "rbxassetid://10723364957",
    ["file-lock-2"] = "rbxassetid://10723364861",
    ["file-minus"] = "rbxassetid://10723365254",
    ["file-minus-2"] = "rbxassetid://10723365086",
    ["file-output"] = "rbxassetid://10723365457",
    ["file-pie-chart"] = "rbxassetid://10723365598",
    ["file-plus"] = "rbxassetid://10723365877",
    ["file-plus-2"] = "rbxassetid://10723365766",
    ["file-question"] = "rbxassetid://10723365987",
    ["file-scan"] = "rbxassetid://10723366167",
    ["file-search"] = "rbxassetid://10723366550",
    ["file-search-2"] = "rbxassetid://10723366340",
    ["file-signature"] = "rbxassetid://10723366741",
    ["file-spreadsheet"] = "rbxassetid://10723366962",
    ["file-symlink"] = "rbxassetid://10723367098",
    ["file-terminal"] = "rbxassetid://10723367244",
    ["file-text"] = "rbxassetid://10723367380",
    ["file-type"] = "rbxassetid://10723367606",
    ["file-type-2"] = "rbxassetid://10723367509",
    ["file-up"] = "rbxassetid://10723367734",
    ["file-video"] = "rbxassetid://10723373884",
    ["file-video-2"] = "rbxassetid://10723367834",
    ["file-volume"] = "rbxassetid://10723374172",
    ["file-volume-2"] = "rbxassetid://10723374030",
    ["file-warning"] = "rbxassetid://10723374276",
    ["file-x"] = "rbxassetid://10723374544",
    ["file-x-2"] = "rbxassetid://10723374378",
    ["files"] = "rbxassetid://10723374759",
    ["film"] = "rbxassetid://10723374981",
    ["filter"] = "rbxassetid://10723375128",
    ["fingerprint"] = "rbxassetid://10723375250",
    ["flag"] = "rbxassetid://10723375890",
    ["flag-off"] = "rbxassetid://10723375443",
    ["flag-triangle-left"] = "rbxassetid://10723375608",
    ["flag-triangle-right"] = "rbxassetid://10723375727",
    ["flame"] = "rbxassetid://10723376114",
    ["flashlight"] = "rbxassetid://10723376471",
    ["flashlight-off"] = "rbxassetid://10723376365",
    ["flask-conical"] = "rbxassetid://10734883986",
    ["flask-round"] = "rbxassetid://10723376614",
    ["flip-horizontal"] = "rbxassetid://10723376884",
    ["flip-horizontal-2"] = "rbxassetid://10723376745",
    ["flip-vertical"] = "rbxassetid://10723377138",
    ["flip-vertical-2"] = "rbxassetid://10723377026",
    ["flower"] = "rbxassetid://10747830374",
    ["flower-2"] = "rbxassetid://10723377305",
    ["focus"] = "rbxassetid://10723377537",
    ["folder"] = "rbxassetid://10723387563",
    ["folder-archive"] = "rbxassetid://10723384478",
    ["folder-check"] = "rbxassetid://10723384605",
    ["folder-clock"] = "rbxassetid://10723384731",
    ["folder-closed"] = "rbxassetid://10723384893",
    ["folder-cog"] = "rbxassetid://10723385213",
    ["folder-cog-2"] = "rbxassetid://10723385036",
    ["folder-down"] = "rbxassetid://10723385338",
    ["folder-edit"] = "rbxassetid://10723385445",
    ["folder-heart"] = "rbxassetid://10723385545",
    ["folder-input"] = "rbxassetid://10723385721",
    ["folder-key"] = "rbxassetid://10723385848",
    ["folder-lock"] = "rbxassetid://10723386005",
    ["folder-minus"] = "rbxassetid://10723386127",
    ["folder-open"] = "rbxassetid://10723386277",
    ["folder-output"] = "rbxassetid://10723386386",
    ["folder-plus"] = "rbxassetid://10723386531",
    ["folder-search"] = "rbxassetid://10723386787",
    ["folder-search-2"] = "rbxassetid://10723386674",
    ["folder-symlink"] = "rbxassetid://10723386930",
    ["folder-tree"] = "rbxassetid://10723387085",
    ["folder-up"] = "rbxassetid://10723387265",
    ["folder-x"] = "rbxassetid://10723387448",
    ["folders"] = "rbxassetid://10723387721",
    ["form-input"] = "rbxassetid://10723387841",
    ["forward"] = "rbxassetid://10723388016",
    ["frame"] = "rbxassetid://10723394389",
    ["framer"] = "rbxassetid://10723394565",
    ["frown"] = "rbxassetid://10723394681",
    ["fuel"] = "rbxassetid://10723394846",
    ["function-square"] = "rbxassetid://10723395041",
    ["gamepad"] = "rbxassetid://10723395457",
    ["gamepad-2"] = "rbxassetid://10723395215",
    ["gauge"] = "rbxassetid://10723395708",
    ["gavel"] = "rbxassetid://10723395896",
    ["gem"] = "rbxassetid://10723396000",
    ["ghost"] = "rbxassetid://10723396107",
    ["gift"] = "rbxassetid://10723396402",
    ["gift-card"] = "rbxassetid://10723396225",
    ["git-branch"] = "rbxassetid://10723396676",
    ["git-branch-plus"] = "rbxassetid://10723396542",
    ["git-commit"] = "rbxassetid://10723396812",
    ["git-compare"] = "rbxassetid://10723396954",
    ["git-fork"] = "rbxassetid://10723397049",
    ["git-merge"] = "rbxassetid://10723397165",
    ["git-pull-request"] = "rbxassetid://10723397431",
    ["git-pull-request-closed"] = "rbxassetid://10723397268",
    ["git-pull-request-draft"] = "rbxassetid://10734884302",
    ["glass"] = "rbxassetid://10723397788",
    ["glass-2"] = "rbxassetid://10723397529",
    ["glass-water"] = "rbxassetid://10723397678",
    ["glasses"] = "rbxassetid://10723397895",
    ["globe"] = "rbxassetid://10723404337",
    ["globe-2"] = "rbxassetid://10723398002",
    ["grab"] = "rbxassetid://10723404472",
    ["graduation-cap"] = "rbxassetid://10723404691",
    ["grape"] = "rbxassetid://10723404822",
    ["grid"] = "rbxassetid://10723404936",
    ["grip-horizontal"] = "rbxassetid://10723405089",
    ["grip-vertical"] = "rbxassetid://10723405236",
    ["hammer"] = "rbxassetid://10723405360",
    ["hand"] = "rbxassetid://10723405649",
    ["hand-metal"] = "rbxassetid://10723405508",
    ["hard-drive"] = "rbxassetid://10723405749",
    ["hard-hat"] = "rbxassetid://10723405859",
    ["hash"] = "rbxassetid://10723405975",
    ["haze"] = "rbxassetid://10723406078",
    ["headphones"] = "rbxassetid://10723406165",
    ["heart"] = "rbxassetid://10723406885",
    ["heart-crack"] = "rbxassetid://10723406299",
    ["heart-handshake"] = "rbxassetid://10723406480",
    ["heart-off"] = "rbxassetid://10723406662",
    ["heart-pulse"] = "rbxassetid://10723406795",
    ["help-circle"] = "rbxassetid://10723406988",
    ["hexagon"] = "rbxassetid://10723407092",
    ["highlighter"] = "rbxassetid://10723407192",
    ["history"] = "rbxassetid://10723407335",
    ["home"] = "rbxassetid://10723407389",
    ["hourglass"] = "rbxassetid://10723407498",
    ["ice-cream"] = "rbxassetid://10723414308",
    ["image"] = "rbxassetid://10723415040",
    ["image-minus"] = "rbxassetid://10723414487",
    ["image-off"] = "rbxassetid://10723414677",
    ["image-plus"] = "rbxassetid://10723414827",
    ["import"] = "rbxassetid://10723415205",
    ["inbox"] = "rbxassetid://10723415335",
    ["indent"] = "rbxassetid://10723415494",
    ["indian-rupee"] = "rbxassetid://10723415642",
    ["infinity"] = "rbxassetid://10723415766",
    ["info"] = "rbxassetid://10723415903",
    ["inspect"] = "rbxassetid://10723416057",
    ["italic"] = "rbxassetid://10723416195",
    ["japanese-yen"] = "rbxassetid://10723416363",
    ["joystick"] = "rbxassetid://10723416527",
    ["key"] = "rbxassetid://10723416652",
    ["keyboard"] = "rbxassetid://10723416765",
    ["lamp"] = "rbxassetid://10723417513",
    ["lamp-ceiling"] = "rbxassetid://10723416922",
    ["lamp-desk"] = "rbxassetid://10723417016",
    ["lamp-floor"] = "rbxassetid://10723417131",
    ["lamp-wall-down"] = "rbxassetid://10723417240",
    ["lamp-wall-up"] = "rbxassetid://10723417356",
    ["landmark"] = "rbxassetid://10723417608",
    ["languages"] = "rbxassetid://10723417703",
    ["laptop"] = "rbxassetid://10723423881",
    ["laptop-2"] = "rbxassetid://10723417797",
    ["lasso"] = "rbxassetid://10723424235",
    ["lasso-select"] = "rbxassetid://10723424058",
    ["laugh"] = "rbxassetid://10723424372",
    ["layers"] = "rbxassetid://10723424505",
    ["layout"] = "rbxassetid://10723425376",
    ["layout-dashboard"] = "rbxassetid://10723424646",
    ["layout-grid"] = "rbxassetid://10723424838",
    ["layout-list"] = "rbxassetid://10723424963",
    ["layout-template"] = "rbxassetid://10723425187",
    ["leaf"] = "rbxassetid://10723425539",
    ["library"] = "rbxassetid://10723425615",
    ["life-buoy"] = "rbxassetid://10723425685",
    ["lightbulb"] = "rbxassetid://10723425852",
    ["lightbulb-off"] = "rbxassetid://10723425762",
    ["line-chart"] = "rbxassetid://10723426393",
    ["link"] = "rbxassetid://10723426722",
    ["link-2"] = "rbxassetid://10723426595",
    ["link-2-off"] = "rbxassetid://10723426513",
    ["list"] = "rbxassetid://10723433811",
    ["list-checks"] = "rbxassetid://10734884548",
    ["list-end"] = "rbxassetid://10723426886",
    ["list-minus"] = "rbxassetid://10723426986",
    ["list-music"] = "rbxassetid://10723427081",
    ["list-ordered"] = "rbxassetid://10723427199",
    ["list-plus"] = "rbxassetid://10723427334",
    ["list-start"] = "rbxassetid://10723427494",
    ["list-video"] = "rbxassetid://10723427619",
    ["list-x"] = "rbxassetid://10723433655",
    ["loader"] = "rbxassetid://10723434070",
    ["loader-2"] = "rbxassetid://10723433935",
    ["locate"] = "rbxassetid://10723434557",
    ["locate-fixed"] = "rbxassetid://10723434236",
    ["locate-off"] = "rbxassetid://10723434379",
    ["lock"] = "rbxassetid://10723434711",
    ["log-in"] = "rbxassetid://10723434830",
    ["log-out"] = "rbxassetid://10723434906",
    ["luggage"] = "rbxassetid://10723434993",
    ["magnet"] = "rbxassetid://10723435069",
    ["mail"] = "rbxassetid://10734885430",
    ["mail-check"] = "rbxassetid://10723435182",
    ["mail-minus"] = "rbxassetid://10723435261",
    ["mail-open"] = "rbxassetid://10723435342",
    ["mail-plus"] = "rbxassetid://10723435443",
    ["mail-question"] = "rbxassetid://10723435515",
    ["mail-search"] = "rbxassetid://10734884739",
    ["mail-warning"] = "rbxassetid://10734885015",
    ["mail-x"] = "rbxassetid://10734885247",
    ["mails"] = "rbxassetid://10734885614",
    ["map"] = "rbxassetid://10734886202",
    ["map-pin"] = "rbxassetid://10734886004",
    ["map-pin-off"] = "rbxassetid://10734885803",
    ["maximize"] = "rbxassetid://10734886735",
    ["maximize-2"] = "rbxassetid://10734886496",
    ["medal"] = "rbxassetid://10734887072",
    ["megaphone"] = "rbxassetid://10734887454",
    ["megaphone-off"] = "rbxassetid://10734887311",
    ["meh"] = "rbxassetid://10734887603",
    ["menu"] = "rbxassetid://10734887784",
    ["message-circle"] = "rbxassetid://10734888000",
    ["message-square"] = "rbxassetid://10734888228",
    ["mic"] = "rbxassetid://10734888864",
    ["mic-2"] = "rbxassetid://10734888430",
    ["mic-off"] = "rbxassetid://10734888646",
    ["microscope"] = "rbxassetid://10734889106",
    ["microwave"] = "rbxassetid://10734895076",
    ["milestone"] = "rbxassetid://10734895310",
    ["minimize"] = "rbxassetid://10734895698",
    ["minimize-2"] = "rbxassetid://10734895530",
    ["minus"] = "rbxassetid://10734896206",
    ["minus-circle"] = "rbxassetid://10734895856",
    ["minus-square"] = "rbxassetid://10734896029",
    ["monitor"] = "rbxassetid://10734896881",
    ["monitor-off"] = "rbxassetid://10734896360",
    ["monitor-speaker"] = "rbxassetid://10734896512",
    ["moon"] = "rbxassetid://10734897102",
    ["more-horizontal"] = "rbxassetid://10734897250",
    ["more-vertical"] = "rbxassetid://10734897387",
    ["mountain"] = "rbxassetid://10734897956",
    ["mountain-snow"] = "rbxassetid://10734897665",
    ["mouse"] = "rbxassetid://10734898592",
    ["mouse-pointer"] = "rbxassetid://10734898476",
    ["mouse-pointer-2"] = "rbxassetid://10734898194",
    ["mouse-pointer-click"] = "rbxassetid://10734898355",
    ["move"] = "rbxassetid://10734900011",
    ["move-3d"] = "rbxassetid://10734898756",
    ["move-diagonal"] = "rbxassetid://10734899164",
    ["move-diagonal-2"] = "rbxassetid://10734898934",
    ["move-horizontal"] = "rbxassetid://10734899414",
    ["move-vertical"] = "rbxassetid://10734899821",
    ["music"] = "rbxassetid://10734905958",
    ["music-2"] = "rbxassetid://10734900215",
    ["music-3"] = "rbxassetid://10734905665",
    ["music-4"] = "rbxassetid://10734905823",
    ["navigation"] = "rbxassetid://10734906744",
    ["navigation-2"] = "rbxassetid://10734906332",
    ["navigation-2-off"] = "rbxassetid://10734906144",
    ["navigation-off"] = "rbxassetid://10734906580",
    ["network"] = "rbxassetid://10734906975",
    ["newspaper"] = "rbxassetid://10734907168",
    ["octagon"] = "rbxassetid://10734907361",
    ["option"] = "rbxassetid://10734907649",
    ["outdent"] = "rbxassetid://10734907933",
    ["package"] = "rbxassetid://10734909540",
    ["package-2"] = "rbxassetid://10734908151",
    ["package-check"] = "rbxassetid://10734908384",
    ["package-minus"] = "rbxassetid://10734908626",
    ["package-open"] = "rbxassetid://10734908793",
    ["package-plus"] = "rbxassetid://10734909016",
    ["package-search"] = "rbxassetid://10734909196",
    ["package-x"] = "rbxassetid://10734909375",
    ["paint-bucket"] = "rbxassetid://10734909847",
    ["paintbrush"] = "rbxassetid://10734910187",
    ["paintbrush-2"] = "rbxassetid://10734910030",
    ["palette"] = "rbxassetid://10734910430",
    ["palmtree"] = "rbxassetid://10734910680",
    ["paperclip"] = "rbxassetid://10734910927",
    ["party-popper"] = "rbxassetid://10734918735",
    ["pause"] = "rbxassetid://10734919336",
    ["pause-circle"] = "rbxassetid://10735024209",
    ["pause-octagon"] = "rbxassetid://10734919143",
    ["pen-tool"] = "rbxassetid://10734919503",
    ["pencil"] = "rbxassetid://10734919691",
    ["percent"] = "rbxassetid://10734919919",
    ["person-standing"] = "rbxassetid://10734920149",
    ["phone"] = "rbxassetid://10734921524",
    ["phone-call"] = "rbxassetid://10734920305",
    ["phone-forwarded"] = "rbxassetid://10734920508",
    ["phone-incoming"] = "rbxassetid://10734920694",
    ["phone-missed"] = "rbxassetid://10734920845",
    ["phone-off"] = "rbxassetid://10734921077",
    ["phone-outgoing"] = "rbxassetid://10734921288",
    ["pie-chart"] = "rbxassetid://10734921727",
    ["piggy-bank"] = "rbxassetid://10734921935",
    ["pin"] = "rbxassetid://10734922324",
    ["pin-off"] = "rbxassetid://10734922180",
    ["pipette"] = "rbxassetid://10734922497",
    ["pizza"] = "rbxassetid://10734922774",
    ["plane"] = "rbxassetid://10734922971",
    ["play"] = "rbxassetid://10734923549",
    ["play-circle"] = "rbxassetid://10734923214",
    ["plus"] = "rbxassetid://10734924532",
    ["plus-circle"] = "rbxassetid://10734923868",
    ["plus-square"] = "rbxassetid://10734924219",
    ["podcast"] = "rbxassetid://10734929553",
    ["pointer"] = "rbxassetid://10734929723",
    ["pound-sterling"] = "rbxassetid://10734929981",
    ["power"] = "rbxassetid://10734930466",
    ["power-off"] = "rbxassetid://10734930257",
    ["printer"] = "rbxassetid://10734930632",
    ["puzzle"] = "rbxassetid://10734930886",
    ["quote"] = "rbxassetid://10734931234",
    ["radio"] = "rbxassetid://10734931596",
    ["radio-receiver"] = "rbxassetid://10734931402",
    ["rectangle-horizontal"] = "rbxassetid://10734931777",
    ["rectangle-vertical"] = "rbxassetid://10734932081",
    ["recycle"] = "rbxassetid://10734932295",
    ["redo"] = "rbxassetid://10734932822",
    ["redo-2"] = "rbxassetid://10734932586",
    ["refresh-ccw"] = "rbxassetid://10734933056",
    ["refresh-cw"] = "rbxassetid://10734933222",
    ["refrigerator"] = "rbxassetid://10734933465",
    ["regex"] = "rbxassetid://10734933655",
    ["repeat"] = "rbxassetid://10734933966",
    ["repeat-1"] = "rbxassetid://10734933826",
    ["reply"] = "rbxassetid://10734934252",
    ["reply-all"] = "rbxassetid://10734934132",
    ["rewind"] = "rbxassetid://10734934347",
    ["rocket"] = "rbxassetid://10734934585",
    ["rocking-chair"] = "rbxassetid://10734939942",
    ["rotate-3d"] = "rbxassetid://10734940107",
    ["rotate-ccw"] = "rbxassetid://10734940376",
    ["rotate-cw"] = "rbxassetid://10734940654",
    ["rss"] = "rbxassetid://10734940825",
    ["ruler"] = "rbxassetid://10734941018",
    ["russian-ruble"] = "rbxassetid://10734941199",
    ["sailboat"] = "rbxassetid://10734941354",
    ["save"] = "rbxassetid://10734941499",
    ["scale"] = "rbxassetid://10734941912",
    ["scale-3d"] = "rbxassetid://10734941739",
    ["scaling"] = "rbxassetid://10734942072",
    ["scan"] = "rbxassetid://10734942565",
    ["scan-face"] = "rbxassetid://10734942198",
    ["scan-line"] = "rbxassetid://10734942351",
    ["scissors"] = "rbxassetid://10734942778",
    ["screen-share"] = "rbxassetid://10734943193",
    ["screen-share-off"] = "rbxassetid://10734942967",
    ["scroll"] = "rbxassetid://10734943448",
    ["search"] = "rbxassetid://10734943674",
    ["send"] = "rbxassetid://10734943902",
    ["separator-horizontal"] = "rbxassetid://10734944115",
    ["separator-vertical"] = "rbxassetid://10734944326",
    ["server"] = "rbxassetid://10734949856",
    ["server-cog"] = "rbxassetid://10734944444",
    ["server-crash"] = "rbxassetid://10734944554",
    ["server-off"] = "rbxassetid://10734944668",
    ["settings"] = "rbxassetid://10734950309",
    ["settings-2"] = "rbxassetid://10734950020",
    ["share"] = "rbxassetid://10734950813",
    ["share-2"] = "rbxassetid://10734950553",
    ["sheet"] = "rbxassetid://10734951038",
    ["shield"] = "rbxassetid://10734951847",
    ["shield-alert"] = "rbxassetid://10734951173",
    ["shield-check"] = "rbxassetid://10734951367",
    ["shield-close"] = "rbxassetid://10734951535",
    ["shield-off"] = "rbxassetid://10734951684",
    ["shirt"] = "rbxassetid://10734952036",
    ["shopping-bag"] = "rbxassetid://10734952273",
    ["shopping-cart"] = "rbxassetid://10734952479",
    ["shovel"] = "rbxassetid://10734952773",
    ["shower-head"] = "rbxassetid://10734952942",
    ["shrink"] = "rbxassetid://10734953073",
    ["shrub"] = "rbxassetid://10734953241",
    ["shuffle"] = "rbxassetid://10734953451",
    ["sidebar"] = "rbxassetid://10734954301",
    ["sidebar-close"] = "rbxassetid://10734953715",
    ["sidebar-open"] = "rbxassetid://10734954000",
    ["sigma"] = "rbxassetid://10734954538",
    ["signal"] = "rbxassetid://10734961133",
    ["signal-high"] = "rbxassetid://10734954807",
    ["signal-low"] = "rbxassetid://10734955080",
    ["signal-medium"] = "rbxassetid://10734955336",
    ["signal-zero"] = "rbxassetid://10734960878",
    ["siren"] = "rbxassetid://10734961284",
    ["skip-back"] = "rbxassetid://10734961526",
    ["skip-forward"] = "rbxassetid://10734961809",
    ["skull"] = "rbxassetid://10734962068",
    ["slack"] = "rbxassetid://10734962339",
    ["slash"] = "rbxassetid://10734962600",
    ["slice"] = "rbxassetid://10734963024",
    ["sliders"] = "rbxassetid://10734963400",
    ["sliders-horizontal"] = "rbxassetid://10734963191",
    ["smartphone"] = "rbxassetid://10734963940",
    ["smartphone-charging"] = "rbxassetid://10734963671",
    ["smile"] = "rbxassetid://10734964441",
    ["smile-plus"] = "rbxassetid://10734964188",
    ["snowflake"] = "rbxassetid://10734964600",
    ["sofa"] = "rbxassetid://10734964852",
    ["sort-asc"] = "rbxassetid://10734965115",
    ["sort-desc"] = "rbxassetid://10734965287",
    ["speaker"] = "rbxassetid://10734965419",
    ["sprout"] = "rbxassetid://10734965572",
    ["square"] = "rbxassetid://10734965702",
    ["star"] = "rbxassetid://10734966248",
    ["star-half"] = "rbxassetid://10734965897",
    ["star-off"] = "rbxassetid://10734966097",
    ["stethoscope"] = "rbxassetid://10734966384",
    ["sticker"] = "rbxassetid://10734972234",
    ["sticky-note"] = "rbxassetid://10734972463",
    ["stop-circle"] = "rbxassetid://10734972621",
    ["stretch-horizontal"] = "rbxassetid://10734972862",
    ["stretch-vertical"] = "rbxassetid://10734973130",
    ["strikethrough"] = "rbxassetid://10734973290",
    ["subscript"] = "rbxassetid://10734973457",
    ["sun"] = "rbxassetid://10734974297",
    ["sun-dim"] = "rbxassetid://10734973645",
    ["sun-medium"] = "rbxassetid://10734973778",
    ["sun-moon"] = "rbxassetid://10734973999",
    ["sun-snow"] = "rbxassetid://10734974130",
    ["sunrise"] = "rbxassetid://10734974522",
    ["sunset"] = "rbxassetid://10734974689",
    ["superscript"] = "rbxassetid://10734974850",
    ["swiss-franc"] = "rbxassetid://10734975024",
    ["switch-camera"] = "rbxassetid://10734975214",
    ["sword"] = "rbxassetid://10734975486",
    ["swords"] = "rbxassetid://10734975692",
    ["syringe"] = "rbxassetid://10734975932",
    ["table"] = "rbxassetid://10734976230",
    ["table-2"] = "rbxassetid://10734976097",
    ["tablet"] = "rbxassetid://10734976394",
    ["tag"] = "rbxassetid://10734976528",
    ["tags"] = "rbxassetid://10734976739",
    ["target"] = "rbxassetid://10734977012",
    ["tent"] = "rbxassetid://10734981750",
    ["terminal"] = "rbxassetid://10734982144",
    ["terminal-square"] = "rbxassetid://10734981995",
    ["text-cursor"] = "rbxassetid://10734982395",
    ["text-cursor-input"] = "rbxassetid://10734982297",
    ["thermometer"] = "rbxassetid://10734983134",
    ["thermometer-snowflake"] = "rbxassetid://10734982571",
    ["thermometer-sun"] = "rbxassetid://10734982771",
    ["thumbs-down"] = "rbxassetid://10734983359",
    ["thumbs-up"] = "rbxassetid://10734983629",
    ["ticket"] = "rbxassetid://10734983868",
    ["timer"] = "rbxassetid://10734984606",
    ["timer-off"] = "rbxassetid://10734984138",
    ["timer-reset"] = "rbxassetid://10734984355",
    ["toggle-left"] = "rbxassetid://10734984834",
    ["toggle-right"] = "rbxassetid://10734985040",
    ["tornado"] = "rbxassetid://10734985247",
    ["toy-brick"] = "rbxassetid://10747361919",
    ["train"] = "rbxassetid://10747362105",
    ["trash"] = "rbxassetid://10747362393",
    ["trash-2"] = "rbxassetid://10747362241",
    ["tree-deciduous"] = "rbxassetid://10747362534",
    ["tree-pine"] = "rbxassetid://10747362748",
    ["trees"] = "rbxassetid://10747363016",
    ["trending-down"] = "rbxassetid://10747363205",
    ["trending-up"] = "rbxassetid://10747363465",
    ["triangle"] = "rbxassetid://10747363621",
    ["trophy"] = "rbxassetid://10747363809",
    ["truck"] = "rbxassetid://10747364031",
    ["tv"] = "rbxassetid://10747364593",
    ["tv-2"] = "rbxassetid://10747364302",
    ["type"] = "rbxassetid://10747364761",
    ["umbrella"] = "rbxassetid://10747364971",
    ["underline"] = "rbxassetid://10747365191",
    ["undo"] = "rbxassetid://10747365484",
    ["undo-2"] = "rbxassetid://10747365359",
    ["unlink"] = "rbxassetid://10747365771",
    ["unlink-2"] = "rbxassetid://10747397871",
    ["unlock"] = "rbxassetid://10747366027",
    ["upload"] = "rbxassetid://10747366434",
    ["upload-cloud"] = "rbxassetid://10747366266",
    ["usb"] = "rbxassetid://10747366606",
    ["user"] = "rbxassetid://10747373176",
    ["user-check"] = "rbxassetid://10747371901",
    ["user-cog"] = "rbxassetid://10747372167",
    ["user-minus"] = "rbxassetid://10747372346",
    ["user-plus"] = "rbxassetid://10747372702",
    ["user-x"] = "rbxassetid://10747372992",
    ["users"] = "rbxassetid://10747373426",
    ["utensils"] = "rbxassetid://10747373821",
    ["utensils-crossed"] = "rbxassetid://10747373629",
    ["venetian-mask"] = "rbxassetid://10747374003",
    ["verified"] = "rbxassetid://10747374131",
    ["vibrate"] = "rbxassetid://10747374489",
    ["vibrate-off"] = "rbxassetid://10747374269",
    ["video"] = "rbxassetid://10747374938",
    ["video-off"] = "rbxassetid://10747374721",
    ["view"] = "rbxassetid://10747375132",
    ["voicemail"] = "rbxassetid://10747375281",
    ["volume"] = "rbxassetid://10747376008",
    ["volume-1"] = "rbxassetid://10747375450",
    ["volume-2"] = "rbxassetid://10747375679",
    ["volume-x"] = "rbxassetid://10747375880",
    ["wallet"] = "rbxassetid://10747376205",
    ["wand"] = "rbxassetid://10747376565",
    ["wand-2"] = "rbxassetid://10747376349",
    ["watch"] = "rbxassetid://10747376722",
    ["waves"] = "rbxassetid://10747376931",
    ["webcam"] = "rbxassetid://10747381992",
    ["wifi"] = "rbxassetid://10747382504",
    ["wifi-off"] = "rbxassetid://10747382268",
    ["wind"] = "rbxassetid://10747382750",
    ["wrap-text"] = "rbxassetid://10747383065",
    ["wrench"] = "rbxassetid://10747383470",
    ["x"] = "rbxassetid://10747384394",
    ["x-circle"] = "rbxassetid://10747383819",
    ["x-octagon"] = "rbxassetid://10747384037",
    ["x-square"] = "rbxassetid://10747384217",
    ["zoom-in"] = "rbxassetid://10747384552",
    ["zoom-out"] = "rbxassetid://10747384679",
}

-- Accepts a bare Lucide name ("settings"), a "lucide-settings" style key,
-- or an already-complete asset URI (rbxassetid://..., rbxthumb://...,
-- rbxasset://..., or a plain http(s) image link) so custom icons still
-- work. Returns nil if it's an unrecognized name so callers can just
-- skip showing an icon rather than erroring.
local function GetIconAsset(icon)
    if not icon then
        return nil
    end
    if typeof(icon) ~= "string" then
        return nil
    end
    if icon:match("^rbxassetid://") or icon:match("^rbxthumb://") or icon:match("^rbxasset://") or icon:match("^https?://") then
        return icon
    end
    local key = icon:gsub("^lucide%-", "")
    return LucideIcons[key]
end

local ui = Instance.new("ScreenGui")
ui.Name = "ui"
ui.Parent = game.CoreGui
ui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

coroutine.wrap(
    function()
        while wait() do
            lib.RainbowColorValue = lib.RainbowColorValue + 1 / 255
            lib.HueSelectionPosition = lib.HueSelectionPosition + 1

            if lib.RainbowColorValue >= 1 then
                lib.RainbowColorValue = 0
            end

            if lib.HueSelectionPosition == 80 then
                lib.HueSelectionPosition = 0
            end
        end
    end
)()

local function MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos =
            UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,
            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )
        object.Position = pos
    end

    topbarobject.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                Dragging = true
                DragStart = input.Position
                StartPosition = object.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            Dragging = false
                        end
                    end
                )
            end
        end
    )

    topbarobject.InputChanged:Connect(
        function(input)
            if
                input.UserInputType == Enum.UserInputType.MouseMovement or
                    input.UserInputType == Enum.UserInputType.Touch
             then
                DragInput = input
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if input == DragInput and Dragging then
                Update(input)
            end
        end
    )
end

function lib:Window(text, preset, closebind)
    CloseBind = closebind or Enum.KeyCode.RightControl
    PresetColor = preset or Color3.fromRGB(44, 120, 224)
    fs = false
    local Main = Instance.new("Frame")
    local TabHold = Instance.new("Frame")
    local TabHoldLayout = Instance.new("UIListLayout")
    local Title = Instance.new("TextLabel")
    local TabFolder = Instance.new("Folder")
    local DragFrame = Instance.new("Frame")

    Main.Name = "Main"
    Main.Parent = ui
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    Main.Visible = true

    TabHold.Name = "TabHold"
    TabHold.Parent = Main
    TabHold.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TabHold.BackgroundTransparency = 1.000
    TabHold.Position = UDim2.new(0.0339285731, 0, 0.147335425, 0)
    TabHold.Size = UDim2.new(0, 107, 0, 254)

    TabHoldLayout.Name = "TabHoldLayout"
    TabHoldLayout.Parent = TabHold
    TabHoldLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabHoldLayout.Padding = UDim.new(0, 11)

    Title.Name = "Title"
    Title.Parent = Main
    Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1.000
    Title.Position = UDim2.new(0, 19, 0, 9)
    Title.Size = UDim2.new(0, 200, 0, 23)
    Title.Font = Enum.Font.GothamSemibold
    Title.Text = text
    Title.TextColor3 = Color3.fromRGB(68, 68, 68)
    Title.TextSize = 12.000
    Title.TextXAlignment = Enum.TextXAlignment.Left

    DragFrame.Name = "DragFrame"
    DragFrame.Parent = Main
    DragFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    DragFrame.BackgroundTransparency = 1.000
    DragFrame.Size = UDim2.new(0, 560, 0, 41)

    local FullSize = UDim2.new(0, 560, 0, 319)
    local MinimizedSize = UDim2.new(0, 560, 0, 41)

    local CloseBtn = Instance.new("TextButton")
    local CloseBtnCorner = Instance.new("UICorner")
    local CloseBtnTitle = Instance.new("TextLabel")
    local MinimizeBtn = Instance.new("TextButton")
    local MinimizeBtnCorner = Instance.new("UICorner")
    local MinimizeBtnTitle = Instance.new("TextLabel")

    CloseBtn.Name = "CloseBtn"
    CloseBtn.Parent = Main
    CloseBtn.AnchorPoint = Vector2.new(1, 0)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    CloseBtn.BorderSizePixel = 0
    CloseBtn.Position = UDim2.new(1, -12, 0, 9)
    CloseBtn.Size = UDim2.new(0, 23, 0, 23)
    CloseBtn.AutoButtonColor = false
    CloseBtn.Font = Enum.Font.SourceSans
    CloseBtn.Text = ""
    CloseBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    CloseBtn.TextSize = 14.000
    CloseBtn.ZIndex = 5

    CloseBtnCorner.CornerRadius = UDim.new(0, 5)
    CloseBtnCorner.Name = "CloseBtnCorner"
    CloseBtnCorner.Parent = CloseBtn

    CloseBtnTitle.Name = "CloseBtnTitle"
    CloseBtnTitle.Parent = CloseBtn
    CloseBtnTitle.BackgroundTransparency = 1.000
    CloseBtnTitle.Size = UDim2.new(1, 0, 1, 0)
    CloseBtnTitle.Font = Enum.Font.GothamBold
    CloseBtnTitle.Text = "X"
    CloseBtnTitle.TextColor3 = Color3.fromRGB(210, 210, 210)
    CloseBtnTitle.TextSize = 14.000
    CloseBtnTitle.ZIndex = 5

    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Parent = Main
    MinimizeBtn.AnchorPoint = Vector2.new(1, 0)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MinimizeBtn.BorderSizePixel = 0
    MinimizeBtn.Position = UDim2.new(1, -40, 0, 9)
    MinimizeBtn.Size = UDim2.new(0, 23, 0, 23)
    MinimizeBtn.AutoButtonColor = false
    MinimizeBtn.Font = Enum.Font.SourceSans
    MinimizeBtn.Text = ""
    MinimizeBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
    MinimizeBtn.TextSize = 14.000
    MinimizeBtn.ZIndex = 5

    MinimizeBtnCorner.CornerRadius = UDim.new(0, 5)
    MinimizeBtnCorner.Name = "MinimizeBtnCorner"
    MinimizeBtnCorner.Parent = MinimizeBtn

    MinimizeBtnTitle.Name = "MinimizeBtnTitle"
    MinimizeBtnTitle.Parent = MinimizeBtn
    MinimizeBtnTitle.BackgroundTransparency = 1.000
    MinimizeBtnTitle.Size = UDim2.new(1, 0, 1, 0)
    MinimizeBtnTitle.Font = Enum.Font.GothamBold
    MinimizeBtnTitle.Text = "_"
    MinimizeBtnTitle.TextColor3 = Color3.fromRGB(210, 210, 210)
    MinimizeBtnTitle.TextSize = 14.000
    MinimizeBtnTitle.ZIndex = 5

    CloseBtn.MouseEnter:Connect(
        function()
            TweenService:Create(
                CloseBtn,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(190, 60, 60)}
            ):Play()
        end
    )
    CloseBtn.MouseLeave:Connect(
        function()
            TweenService:Create(
                CloseBtn,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}
            ):Play()
        end
    )

    MinimizeBtn.MouseEnter:Connect(
        function()
            TweenService:Create(
                MinimizeBtn,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
            ):Play()
        end
    )
    MinimizeBtn.MouseLeave:Connect(
        function()
            TweenService:Create(
                MinimizeBtn,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}
            ):Play()
        end
    )

    Main:TweenSize(FullSize, Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)

    MakeDraggable(DragFrame, Main)

    local uitoggled = false
    local minimized = false

    local function OpenSize()
        return minimized and MinimizedSize or FullSize
    end

    local function SetClosed(shouldClose)
        if shouldClose == uitoggled then
            return
        end
        uitoggled = shouldClose
        if uitoggled then
            Main:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
            wait(.5)
            Main.Visible = false
        else
            Main.Visible = true
            Main:TweenSize(OpenSize(), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .6, true)
        end
    end

    UserInputService.InputBegan:Connect(
        function(io, p)
            if io.KeyCode == CloseBind then
                SetClosed(not uitoggled)
            end
        end
    )

    -- Round mobile toggle button: opens/closes the panel with a tap, since
    -- touch users have no keybind. Parented to `ui` directly (not Main) so
    -- it stays visible even while the panel itself is closed.
    local MobileToggleBtn = Instance.new("TextButton")
    local MobileToggleBtnCorner = Instance.new("UICorner")

    MobileToggleBtn.Name = "MobileToggleBtn"
    MobileToggleBtn.Parent = ui
    MobileToggleBtn.AnchorPoint = Vector2.new(1, 1)
    MobileToggleBtn.Position = UDim2.new(1, -20, 1, -20)
    MobileToggleBtn.Size = UDim2.new(0, 50, 0, 50)
    MobileToggleBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MobileToggleBtn.BorderSizePixel = 0
    MobileToggleBtn.AutoButtonColor = false
    MobileToggleBtn.Font = Enum.Font.GothamBold
    MobileToggleBtn.Text = string.upper(string.sub(text, 1, 1))
    MobileToggleBtn.TextColor3 = Color3.fromRGB(210, 210, 210)
    MobileToggleBtn.TextSize = 18.000
    MobileToggleBtn.ZIndex = 10
    -- only show this on touch devices; desktop users already have the
    -- close/minimize buttons and the CloseBind keybind
    MobileToggleBtn.Visible = UserInputService.TouchEnabled

    MobileToggleBtnCorner.CornerRadius = UDim.new(1, 0)
    MobileToggleBtnCorner.Name = "MobileToggleBtnCorner"
    MobileToggleBtnCorner.Parent = MobileToggleBtn

    MobileToggleBtn.MouseEnter:Connect(
        function()
            TweenService:Create(
                MobileToggleBtn,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
            ):Play()
        end
    )
    MobileToggleBtn.MouseLeave:Connect(
        function()
            TweenService:Create(
                MobileToggleBtn,
                TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}
            ):Play()
        end
    )

    -- Draggable so it doesn't end up parked on top of the jump button.
    -- We track movement distance so a quick tap still toggles the panel,
    -- while an actual drag just repositions the button instead.
    local mobileBtnDragging = false
    local mobileBtnDragMoved = false
    local mobileBtnDragStart = nil
    local mobileBtnStartPos = nil
    local DRAG_TAP_THRESHOLD = 6

    MobileToggleBtn.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                mobileBtnDragging = true
                mobileBtnDragMoved = false
                mobileBtnDragStart = Vector2.new(input.Position.X, input.Position.Y)
                mobileBtnStartPos = MobileToggleBtn.Position
            end
        end
    )

    UserInputService.InputChanged:Connect(
        function(input)
            if
                mobileBtnDragging and
                    (input.UserInputType == Enum.UserInputType.MouseMovement or
                        input.UserInputType == Enum.UserInputType.Touch)
             then
                local delta = Vector2.new(input.Position.X, input.Position.Y) - mobileBtnDragStart

                if not mobileBtnDragMoved and delta.Magnitude > DRAG_TAP_THRESHOLD then
                    mobileBtnDragMoved = true
                end

                if mobileBtnDragMoved then
                    local screenSize = ui.AbsoluteSize
                    local btnSize = MobileToggleBtn.AbsoluteSize
                    local minOffsetX = -(screenSize.X - btnSize.X)
                    local minOffsetY = -(screenSize.Y - btnSize.Y)

                    local newOffsetX = math.clamp(mobileBtnStartPos.X.Offset + delta.X, minOffsetX, 0)
                    local newOffsetY = math.clamp(mobileBtnStartPos.Y.Offset + delta.Y, minOffsetY, 0)

                    MobileToggleBtn.Position = UDim2.new(1, newOffsetX, 1, newOffsetY)
                end
            end
        end
    )

    UserInputService.InputEnded:Connect(
        function(input)
            if
                mobileBtnDragging and
                    (input.UserInputType == Enum.UserInputType.MouseButton1 or
                        input.UserInputType == Enum.UserInputType.Touch)
             then
                mobileBtnDragging = false
                if not mobileBtnDragMoved then
                    -- released without moving past the threshold - treat as a tap
                    SetClosed(not uitoggled)
                end
            end
        end
    )

    CloseBtn.MouseButton1Click:Connect(
        function()
            SetClosed(true)
        end
    )

    local lastActiveTab = nil

    MinimizeBtn.MouseButton1Click:Connect(
        function()
            minimized = not minimized

            if minimized then
                -- remember which tab was open, then hide the tab list + tab
                -- content so they don't get squashed into the collapsed bar
                for i, v in next, TabFolder:GetChildren() do
                    if v.Name == "Tab" then
                        if v.Visible then
                            lastActiveTab = v
                        end
                        v.Visible = false
                    end
                end
                TabHold.Visible = false
            else
                TabHold.Visible = true
                if lastActiveTab then
                    lastActiveTab.Visible = true
                end
            end

            if not uitoggled then
                Main:TweenSize(OpenSize(), Enum.EasingDirection.Out, Enum.EasingStyle.Quart, .4, true)
            end
        end
    )

    TabFolder.Name = "TabFolder"
    TabFolder.Parent = Main

    function lib:ChangePresetColor(toch)
        PresetColor = toch
    end

    function lib:Destroy()
        ui:Destroy()
    end

    function lib:Notification(texttitle, textdesc, textbtn)
        local NotificationHold = Instance.new("TextButton")
        local NotificationFrame = Instance.new("Frame")
        local OkayBtn = Instance.new("TextButton")
        local OkayBtnCorner = Instance.new("UICorner")
        local OkayBtnTitle = Instance.new("TextLabel")
        local NotificationTitle = Instance.new("TextLabel")
        local NotificationDesc = Instance.new("TextLabel")

        NotificationHold.Name = "NotificationHold"
        NotificationHold.Parent = Main
        NotificationHold.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.BackgroundTransparency = 1.000
        NotificationHold.BorderSizePixel = 0
        NotificationHold.Size = UDim2.new(0, 560, 0, 319)
        NotificationHold.AutoButtonColor = false
        NotificationHold.Font = Enum.Font.SourceSans
        NotificationHold.Text = ""
        NotificationHold.TextColor3 = Color3.fromRGB(0, 0, 0)
        NotificationHold.TextSize = 14.000

        TweenService:Create(
            NotificationHold,
            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
            {BackgroundTransparency = 0.7}
        ):Play()
        wait(0.4)

        NotificationFrame.Name = "NotificationFrame"
        NotificationFrame.Parent = NotificationHold
        NotificationFrame.AnchorPoint = Vector2.new(0.5, 0.5)
        NotificationFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        NotificationFrame.BorderSizePixel = 0
        NotificationFrame.ClipsDescendants = true
        NotificationFrame.Position = UDim2.new(0.5, 0, 0.498432577, 0)

        NotificationFrame:TweenSize(
            UDim2.new(0, 164, 0, 193),
            Enum.EasingDirection.Out,
            Enum.EasingStyle.Quart,
            .6,
            true
        )

        OkayBtn.Name = "OkayBtn"
        OkayBtn.Parent = NotificationFrame
        OkayBtn.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
        OkayBtn.Position = UDim2.new(0.0609756112, 0, 0.720207274, 0)
        OkayBtn.Size = UDim2.new(0, 144, 0, 42)
        OkayBtn.AutoButtonColor = false
        OkayBtn.Font = Enum.Font.SourceSans
        OkayBtn.Text = ""
        OkayBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        OkayBtn.TextSize = 14.000

        OkayBtnCorner.CornerRadius = UDim.new(0, 5)
        OkayBtnCorner.Name = "OkayBtnCorner"
        OkayBtnCorner.Parent = OkayBtn

        OkayBtnTitle.Name = "OkayBtnTitle"
        OkayBtnTitle.Parent = OkayBtn
        OkayBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.BackgroundTransparency = 1.000
        OkayBtnTitle.Position = UDim2.new(0.0763888881, 0, 0, 0)
        OkayBtnTitle.Size = UDim2.new(0, 181, 0, 42)
        OkayBtnTitle.Font = Enum.Font.Gotham
        OkayBtnTitle.Text = textbtn
        OkayBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        OkayBtnTitle.TextSize = 14.000
        OkayBtnTitle.TextXAlignment = Enum.TextXAlignment.Left

        NotificationTitle.Name = "NotificationTitle"
        NotificationTitle.Parent = NotificationFrame
        NotificationTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.BackgroundTransparency = 1.000
        NotificationTitle.Position = UDim2.new(0.0670731738, 0, 0.0829015523, 0)
        NotificationTitle.Size = UDim2.new(0, 143, 0, 26)
        NotificationTitle.Font = Enum.Font.Gotham
        NotificationTitle.Text = texttitle
        NotificationTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationTitle.TextSize = 18.000
        NotificationTitle.TextXAlignment = Enum.TextXAlignment.Left

        NotificationDesc.Name = "NotificationDesc"
        NotificationDesc.Parent = NotificationFrame
        NotificationDesc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.BackgroundTransparency = 1.000
        NotificationDesc.Position = UDim2.new(0.0670000017, 0, 0.218999997, 0)
        NotificationDesc.Size = UDim2.new(0, 143, 0, 91)
        NotificationDesc.Font = Enum.Font.Gotham
        NotificationDesc.Text = textdesc
        NotificationDesc.TextColor3 = Color3.fromRGB(255, 255, 255)
        NotificationDesc.TextSize = 15.000
        NotificationDesc.TextWrapped = true
        NotificationDesc.TextXAlignment = Enum.TextXAlignment.Left
        NotificationDesc.TextYAlignment = Enum.TextYAlignment.Top

        OkayBtn.MouseEnter:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}
                ):Play()
            end
        )

        OkayBtn.MouseLeave:Connect(
            function()
                TweenService:Create(
                    OkayBtn,
                    TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}
                ):Play()
            end
        )

        OkayBtn.MouseButton1Click:Connect(
            function()
                NotificationFrame:TweenSize(
                    UDim2.new(0, 0, 0, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .6,
                    true
                )

                wait(0.4)

                TweenService:Create(
                    NotificationHold,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()

                wait(.3)

                NotificationHold:Destroy()
            end
        )
    end
    local tabhold = {}
    function tabhold:Tab(text, icon)
        local TabBtn = Instance.new("TextButton")
        local TabTitle = Instance.new("TextLabel")
        local TabBtnIndicator = Instance.new("Frame")
        local TabBtnIndicatorCorner = Instance.new("UICorner")
        local TabIcon = nil
        local iconAsset = GetIconAsset(icon)

        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabHold
        TabBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabBtn.BackgroundTransparency = 1.000
        TabBtn.Size = UDim2.new(0, 107, 0, 21)
        TabBtn.Font = Enum.Font.SourceSans
        TabBtn.Text = ""
        TabBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabBtn.TextSize = 14.000

        TabTitle.Name = "TabTitle"
        TabTitle.Parent = TabBtn
        TabTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabTitle.BackgroundTransparency = 1.000
        TabTitle.Font = Enum.Font.Gotham
        TabTitle.Text = text
        TabTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
        TabTitle.TextSize = 14.000
        TabTitle.TextXAlignment = Enum.TextXAlignment.Left

        if iconAsset then
            -- shift the title over to make room for the icon
            TabTitle.Position = UDim2.new(0, 20, 0, 0)
            TabTitle.Size = UDim2.new(0, 87, 0, 21)

            TabIcon = Instance.new("ImageLabel")
            TabIcon.Name = "TabIcon"
            TabIcon.Parent = TabBtn
            TabIcon.BackgroundTransparency = 1.000
            TabIcon.Position = UDim2.new(0, 0, 0, 3)
            TabIcon.Size = UDim2.new(0, 15, 0, 15)
            TabIcon.Image = iconAsset
            TabIcon.ImageColor3 = Color3.fromRGB(150, 150, 150)
        else
            TabTitle.Position = UDim2.new(0, 0, 0, 0)
            TabTitle.Size = UDim2.new(0, 107, 0, 21)
        end

        TabBtnIndicator.Name = "TabBtnIndicator"
        TabBtnIndicator.Parent = TabBtn
        TabBtnIndicator.BackgroundColor3 = PresetColor
        TabBtnIndicator.BorderSizePixel = 0
        TabBtnIndicator.Position = UDim2.new(0, 0, 1, 0)
        TabBtnIndicator.Size = UDim2.new(0, 0, 0, 2)

        TabBtnIndicatorCorner.Name = "TabBtnIndicatorCorner"
        TabBtnIndicatorCorner.Parent = TabBtnIndicator

        coroutine.wrap(
            function()
                while wait() do
                    TabBtnIndicator.BackgroundColor3 = PresetColor
                end
            end
        )()

        local Tab = Instance.new("ScrollingFrame")
        local TabLayout = Instance.new("UIListLayout")

        Tab.Name = "Tab"
        Tab.Parent = TabFolder
        Tab.Active = true
        Tab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Tab.BackgroundTransparency = 1.000
        Tab.BorderSizePixel = 0
        Tab.Position = UDim2.new(0.31400001, 0, 0.147, 0)
        Tab.Size = UDim2.new(0, 373, 0, 254)
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
        Tab.ScrollBarThickness = 3
        Tab.Visible = false

        TabLayout.Name = "TabLayout"
        TabLayout.Parent = Tab
        TabLayout.SortOrder = Enum.SortOrder.LayoutOrder
        TabLayout.Padding = UDim.new(0, 6)

        if fs == false then
            fs = true
            TabBtnIndicator.Size = UDim2.new(0, 13, 0, 2)
            TabTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            if TabIcon then
                TabIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            end
            Tab.Visible = true
        end

        TabBtn.MouseButton1Click:Connect(
            function()
                for i, v in next, TabFolder:GetChildren() do
                    if v.Name == "Tab" then
                        v.Visible = false
                    end
                    Tab.Visible = true
                end
                for i, v in next, TabHold:GetChildren() do
                    if v.Name == "TabBtn" then
                        v.TabBtnIndicator:TweenSize(
                            UDim2.new(0, 0, 0, 2),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TabBtnIndicator:TweenSize(
                            UDim2.new(0, 13, 0, 2),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            v.TabTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(150, 150, 150)}
                        ):Play()
                        TweenService:Create(
                            TabTitle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                        local vIcon = v:FindFirstChild("TabIcon")
                        if vIcon then
                            TweenService:Create(
                                vIcon,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {ImageColor3 = Color3.fromRGB(150, 150, 150)}
                            ):Play()
                        end
                        if TabIcon then
                            TweenService:Create(
                                TabIcon,
                                TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                                {ImageColor3 = Color3.fromRGB(255, 255, 255)}
                            ):Play()
                        end
                    end
                end
            end
        )
        local tabcontent = {}
        function tabcontent:Button(text, callback, hasSettings)
            hasSettings = hasSettings == true
            local settingsopen = false

            local Button = Instance.new("TextButton")
            local ButtonCorner = Instance.new("UICorner")
            local ButtonTitle = Instance.new("TextLabel")

            Button.Name = "Button"
            Button.Parent = Tab
            Button.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Button.ClipsDescendants = true
            Button.Size = UDim2.new(0, 363, 0, 42)
            Button.AutoButtonColor = false
            Button.Font = Enum.Font.SourceSans
            Button.Text = ""
            Button.TextColor3 = Color3.fromRGB(0, 0, 0)
            Button.TextSize = 14.000

            ButtonCorner.CornerRadius = UDim.new(0, 5)
            ButtonCorner.Name = "ButtonCorner"
            ButtonCorner.Parent = Button

            ButtonTitle.Name = "ButtonTitle"
            ButtonTitle.Parent = Button
            ButtonTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.BackgroundTransparency = 1.000
            ButtonTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            ButtonTitle.Size = UDim2.new(0, 187, 0, 42)
            ButtonTitle.Font = Enum.Font.Gotham
            ButtonTitle.Text = text
            ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ButtonTitle.TextSize = 14.000
            ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left

            Button.MouseEnter:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}
                    ):Play()
                end
            )

            Button.MouseLeave:Connect(
                function()
                    TweenService:Create(
                        Button,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}
                    ):Play()
                end
            )

            Button.MouseButton1Click:Connect(
                function()
                    pcall(callback)
                end
            )

            -- buttoncontent is returned so a caller can add rows to this button's settings
            -- panel, e.g. local btn = Tab:Button("Kill Aura", fn, true); btn:Label("Range: 15")
            local buttoncontent = {}
            function buttoncontent:Label(labeltext)
            end

            if hasSettings then
                local DotsBtn = Instance.new("TextButton")
                local SettingsHolder = Instance.new("ScrollingFrame")
                local SettingsLayout = Instance.new("UIListLayout")

                DotsBtn.Name = "DotsBtn"
                DotsBtn.Parent = Button
                DotsBtn.AnchorPoint = Vector2.new(1, 0)
                DotsBtn.BackgroundTransparency = 1.000
                DotsBtn.Position = UDim2.new(1, -8, 0, 0)
                DotsBtn.Size = UDim2.new(0, 32, 0, 42)
                DotsBtn.AutoButtonColor = false
                DotsBtn.Font = Enum.Font.GothamBold
                DotsBtn.Text = "..."
                DotsBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
                DotsBtn.TextSize = 22.000
                DotsBtn.ZIndex = 2

                DotsBtn.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            DotsBtn,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                    end
                )
                DotsBtn.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            DotsBtn,
                            TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {TextColor3 = Color3.fromRGB(150, 150, 150)}
                        ):Play()
                    end
                )

                SettingsHolder.Name = "SettingsHolder"
                SettingsHolder.Parent = Button
                SettingsHolder.Active = true
                SettingsHolder.BackgroundTransparency = 1.000
                SettingsHolder.BorderSizePixel = 0
                SettingsHolder.Position = UDim2.new(0, 13, 0, 47)
                SettingsHolder.Size = UDim2.new(0, 337, 0, 0)
                SettingsHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
                SettingsHolder.ScrollBarThickness = 3
                SettingsHolder.ZIndex = 2

                SettingsLayout.Name = "SettingsLayout"
                SettingsLayout.Parent = SettingsHolder
                SettingsLayout.SortOrder = Enum.SortOrder.LayoutOrder
                SettingsLayout.Padding = UDim.new(0, 4)

                -- Recomputes the panel's own size off its content. Returns the visible
                -- (capped, scrollable past 3 rows) height so callers can size Button.
                local function RecalcSettingsHolder()
                    local fullheight = SettingsLayout.AbsoluteContentSize.Y
                    local visibleheight = math.min(fullheight, 78)
                    SettingsHolder.CanvasSize = UDim2.new(0, 0, 0, fullheight)
                    SettingsHolder.Size = UDim2.new(0, 337, 0, visibleheight)
                    return visibleheight
                end

                local function SetSettingsOpen(open)
                    settingsopen = open
                    local visibleheight = RecalcSettingsHolder()
                    if settingsopen then
                        Button:TweenSize(
                            UDim2.new(0, 363, 0, 52 + visibleheight),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    else
                        Button:TweenSize(
                            UDim2.new(0, 363, 0, 42),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    end
                    wait(.2)
                    Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                end

                -- MouseButton1Click fires for real mouse clicks and mobile/touch taps alike,
                -- so this is what lets mobile players open the settings from the dots.
                DotsBtn.MouseButton1Click:Connect(
                    function()
                        SetSettingsOpen(not settingsopen)
                    end
                )

                -- Right click anywhere else on the button (desktop only) does the same thing.
                Button.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton2 then
                            SetSettingsOpen(not settingsopen)
                        end
                    end
                )

                function buttoncontent:Label(labeltext)
                    local SettingLabel = Instance.new("TextLabel")
                    SettingLabel.Name = "SettingLabel"
                    SettingLabel.Parent = SettingsHolder
                    SettingLabel.BackgroundTransparency = 1.000
                    SettingLabel.Size = UDim2.new(0, 337, 0, 22)
                    SettingLabel.Font = Enum.Font.Gotham
                    SettingLabel.Text = labeltext
                    SettingLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                    SettingLabel.TextSize = 13.000
                    SettingLabel.TextXAlignment = Enum.TextXAlignment.Left
                    SettingLabel.TextWrapped = true

                    local visibleheight = RecalcSettingsHolder()
                    if settingsopen then
                        Button:TweenSize(
                            UDim2.new(0, 363, 0, 52 + visibleheight),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                end
            end

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
            return buttoncontent
        end

        function tabcontent:Toggle(text,default, callback)
            local toggled = false

            local Toggle = Instance.new("TextButton")
            local ToggleCorner = Instance.new("UICorner")
            local ToggleTitle = Instance.new("TextLabel")
            local FrameToggle1 = Instance.new("Frame")
            local FrameToggle1Corner = Instance.new("UICorner")
            local FrameToggle2 = Instance.new("Frame")
            local FrameToggle2Corner = Instance.new("UICorner")
            local FrameToggle3 = Instance.new("Frame")
            local FrameToggle3Corner = Instance.new("UICorner")
            local FrameToggleCircle = Instance.new("Frame")
            local FrameToggleCircleCorner = Instance.new("UICorner")

            Toggle.Name = "Toggle"
            Toggle.Parent = Tab
            Toggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Toggle.Position = UDim2.new(0.215625003, 0, 0.446271926, 0)
            Toggle.Size = UDim2.new(0, 363, 0, 42)
            Toggle.AutoButtonColor = false
            Toggle.Font = Enum.Font.SourceSans
            Toggle.Text = ""
            Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            Toggle.TextSize = 14.000

            ToggleCorner.CornerRadius = UDim.new(0, 5)
            ToggleCorner.Name = "ToggleCorner"
            ToggleCorner.Parent = Toggle

            ToggleTitle.Name = "ToggleTitle"
            ToggleTitle.Parent = Toggle
            ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.BackgroundTransparency = 1.000
            ToggleTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            ToggleTitle.Size = UDim2.new(0, 187, 0, 42)
            ToggleTitle.Font = Enum.Font.Gotham
            ToggleTitle.Text = text
            ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ToggleTitle.TextSize = 14.000
            ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            FrameToggle1.Name = "FrameToggle1"
            FrameToggle1.Parent = Toggle
            FrameToggle1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            FrameToggle1.Position = UDim2.new(0.859504104, 0, 0.285714298, 0)
            FrameToggle1.Size = UDim2.new(0, 37, 0, 18)

            FrameToggle1Corner.Name = "FrameToggle1Corner"
            FrameToggle1Corner.Parent = FrameToggle1

            FrameToggle2.Name = "FrameToggle2"
            FrameToggle2.Parent = FrameToggle1
            FrameToggle2.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            FrameToggle2.Position = UDim2.new(0.0489999987, 0, 0.0930000022, 0)
            FrameToggle2.Size = UDim2.new(0, 33, 0, 14)

            FrameToggle2Corner.Name = "FrameToggle2Corner"
            FrameToggle2Corner.Parent = FrameToggle2

            FrameToggle3.Name = "FrameToggle3"
            FrameToggle3.Parent = FrameToggle1
            FrameToggle3.BackgroundColor3 = PresetColor
            FrameToggle3.BackgroundTransparency = 1.000
            FrameToggle3.Size = UDim2.new(0, 37, 0, 18)

            FrameToggle3Corner.Name = "FrameToggle3Corner"
            FrameToggle3Corner.Parent = FrameToggle3

            FrameToggleCircle.Name = "FrameToggleCircle"
            FrameToggleCircle.Parent = FrameToggle1
            FrameToggleCircle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            FrameToggleCircle.Position = UDim2.new(0.127000004, 0, 0.222000003, 0)
            FrameToggleCircle.Size = UDim2.new(0, 10, 0, 10)

            FrameToggleCircleCorner.Name = "FrameToggleCircleCorner"
            FrameToggleCircleCorner.Parent = FrameToggleCircle

            coroutine.wrap(
                function()
                    while wait() do
                        FrameToggle3.BackgroundColor3 = PresetColor
                    end
                end
            )()

            Toggle.MouseButton1Click:Connect(
                function()
                    if toggled == false then
                        TweenService:Create(
                            Toggle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}
                        ):Play()
                        TweenService:Create(
                            FrameToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                        FrameToggleCircle:TweenPosition(
                            UDim2.new(0.587, 0, 0.222000003, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    else
                        TweenService:Create(
                            Toggle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}
                        ):Play()
                        TweenService:Create(
                            FrameToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                        FrameToggleCircle:TweenPosition(
                            UDim2.new(0.127000004, 0, 0.222000003, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                    end
                    toggled = not toggled
                    pcall(callback, toggled)
                end
            )

            if default == true then
                TweenService:Create(
                    Toggle,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}
                ):Play()
                TweenService:Create(
                    FrameToggle1,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()
                TweenService:Create(
                    FrameToggle2,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 1}
                ):Play()
                TweenService:Create(
                    FrameToggle3,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundTransparency = 0}
                ):Play()
                TweenService:Create(
                    FrameToggleCircle,
                    TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                ):Play()
                FrameToggleCircle:TweenPosition(
                    UDim2.new(0.587, 0, 0.222000003, 0),
                    Enum.EasingDirection.Out,
                    Enum.EasingStyle.Quart,
                    .2,
                    true
                )
                toggled = not toggled
            end

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        function tabcontent:Slider(text, min, max, start, callback)
            min = min or 0
            max = max or 100
            if max <= min then
                max = min + 1
            end
            start = math.clamp(start or min, min, max)

            local function ValueToFraction(value)
                return math.clamp((value - min) / (max - min), 0, 1)
            end

            local dragging = false
            local Slider = Instance.new("TextButton")
            local SliderCorner = Instance.new("UICorner")
            local SliderTitle = Instance.new("TextLabel")
            local SliderValue = Instance.new("TextLabel")
            local SlideFrame = Instance.new("Frame")
            local CurrentValueFrame = Instance.new("Frame")
            local SlideCircle = Instance.new("ImageButton")

            Slider.Name = "Slider"
            Slider.Parent = Tab
            Slider.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Slider.Position = UDim2.new(-0.48035714, 0, -0.570532918, 0)
            Slider.Size = UDim2.new(0, 363, 0, 60)
            Slider.AutoButtonColor = false
            Slider.Font = Enum.Font.SourceSans
            Slider.Text = ""
            Slider.TextColor3 = Color3.fromRGB(0, 0, 0)
            Slider.TextSize = 14.000

            SliderCorner.CornerRadius = UDim.new(0, 5)
            SliderCorner.Name = "SliderCorner"
            SliderCorner.Parent = Slider

            SliderTitle.Name = "SliderTitle"
            SliderTitle.Parent = Slider
            SliderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.BackgroundTransparency = 1.000
            SliderTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            SliderTitle.Size = UDim2.new(0, 187, 0, 42)
            SliderTitle.Font = Enum.Font.Gotham
            SliderTitle.Text = text
            SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderTitle.TextSize = 14.000
            SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

            SliderValue.Name = "SliderValue"
            SliderValue.Parent = Slider
            SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.BackgroundTransparency = 1.000
            SliderValue.Position = UDim2.new(0.0358126722, 0, 0, 0)
            SliderValue.Size = UDim2.new(0, 335, 0, 42)
            SliderValue.Font = Enum.Font.Gotham
            SliderValue.Text = tostring(start and math.floor((start / max) * (max - min) + min) or 0)
            SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
            SliderValue.TextSize = 14.000
            SliderValue.TextXAlignment = Enum.TextXAlignment.Right

            SlideFrame.Name = "SlideFrame"
            SlideFrame.Parent = Slider
            SlideFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            SlideFrame.BorderSizePixel = 0
            SlideFrame.Position = UDim2.new(0.0342647657, 0, 0.686091602, 0)
            SlideFrame.Size = UDim2.new(0, 335, 0, 3)

            CurrentValueFrame.Name = "CurrentValueFrame"
            CurrentValueFrame.Parent = SlideFrame
            CurrentValueFrame.BackgroundColor3 = PresetColor
            CurrentValueFrame.BorderSizePixel = 0
            CurrentValueFrame.Size = UDim2.new((start or 0) / max, 0, 0, 3)

            SlideCircle.Name = "SlideCircle"
            SlideCircle.Parent = SlideFrame
            SlideCircle.BackgroundColor3 = PresetColor
            SlideCircle.BackgroundTransparency = 1.000
            SlideCircle.Position = UDim2.new((start or 0) / max, -6, -1.30499995, 0)
            SlideCircle.Size = UDim2.new(0, 11, 0, 11)
            SlideCircle.Image = "rbxassetid://3570695787"
            SlideCircle.ImageColor3 = PresetColor

            coroutine.wrap(
                function()
                    while wait() do
                        CurrentValueFrame.BackgroundColor3 = PresetColor
                        SlideCircle.ImageColor3 = PresetColor
                    end
                end
            )()

            local function move(input)
                local pos =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    -6,
                    -1.30499995,
                    0
                )
                local pos1 =
                    UDim2.new(
                    math.clamp((input.Position.X - SlideFrame.AbsolutePosition.X) / SlideFrame.AbsoluteSize.X, 0, 1),
                    0,
                    0,
                    3
                )
                CurrentValueFrame:TweenSize(pos1, "Out", "Sine", 0.1, true)
                SlideCircle:TweenPosition(pos, "Out", "Sine", 0.1, true)
                local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                SliderValue.Text = tostring(value)
                pcall(callback, value)
            end

            local function StartDrag(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    move(input)
                end
            end

            -- Active must be true on plain Frames/ImageButtons for InputBegan to fire at all
            SlideFrame.Active = true
            SlideFrame.InputBegan:Connect(StartDrag)
            SlideCircle.InputBegan:Connect(StartDrag)

            UserInputService.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        dragging = false
                    end
                end
            )

            UserInputService.InputChanged:Connect(
                function(input)
                    if
                        dragging and
                            (input.UserInputType == Enum.UserInputType.MouseMovement or
                                input.UserInputType == Enum.UserInputType.Touch)
                     then
                        move(input)
                    end
                end
            )
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        function tabcontent:Dropdown(text, list, callback)
            local droptog = false
            local framesize = 0
            local itemcount = 0

            local Dropdown = Instance.new("Frame")
            local DropdownCorner = Instance.new("UICorner")
            local DropdownBtn = Instance.new("TextButton")
            local DropdownTitle = Instance.new("TextLabel")
            local ArrowImg = Instance.new("ImageLabel")
            local DropItemHolder = Instance.new("ScrollingFrame")
            local DropLayout = Instance.new("UIListLayout")

            Dropdown.Name = "Dropdown"
            Dropdown.Parent = Tab
            Dropdown.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Dropdown.ClipsDescendants = true
            Dropdown.Position = UDim2.new(-0.541071415, 0, -0.532915354, 0)
            Dropdown.Size = UDim2.new(0, 363, 0, 42)

            DropdownCorner.CornerRadius = UDim.new(0, 5)
            DropdownCorner.Name = "DropdownCorner"
            DropdownCorner.Parent = Dropdown

            DropdownBtn.Name = "DropdownBtn"
            DropdownBtn.Parent = Dropdown
            DropdownBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownBtn.BackgroundTransparency = 1.000
            DropdownBtn.Size = UDim2.new(0, 363, 0, 42)
            DropdownBtn.Font = Enum.Font.SourceSans
            DropdownBtn.Text = ""
            DropdownBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            DropdownBtn.TextSize = 14.000

            DropdownTitle.Name = "DropdownTitle"
            DropdownTitle.Parent = Dropdown
            DropdownTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.BackgroundTransparency = 1.000
            DropdownTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            DropdownTitle.Size = UDim2.new(0, 187, 0, 42)
            DropdownTitle.Font = Enum.Font.Gotham
            DropdownTitle.Text = text
            DropdownTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            DropdownTitle.TextSize = 14.000
            DropdownTitle.TextXAlignment = Enum.TextXAlignment.Left

            ArrowImg.Name = "ArrowImg"
            ArrowImg.Parent = DropdownTitle
            ArrowImg.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ArrowImg.BackgroundTransparency = 1.000
            ArrowImg.Position = UDim2.new(1.65240645, 0, 0.190476194, 0)
            ArrowImg.Size = UDim2.new(0, 26, 0, 26)
            ArrowImg.Image = "http://www.roblox.com/asset/?id=6034818375"

            DropItemHolder.Name = "DropItemHolder"
            DropItemHolder.Parent = DropdownTitle
            DropItemHolder.Active = true
            DropItemHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            DropItemHolder.BackgroundTransparency = 1.000
            DropItemHolder.BorderSizePixel = 0
            DropItemHolder.Position = UDim2.new(-0.00400000019, 0, 1.04999995, 0)
            DropItemHolder.Size = UDim2.new(0, 342, 0, 0)
            DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
            DropItemHolder.ScrollBarThickness = 3

            DropLayout.Name = "DropLayout"
            DropLayout.Parent = DropItemHolder
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder

            DropdownBtn.MouseButton1Click:Connect(
                function()
                    if droptog == false then
                        Dropdown:TweenSize(
                            UDim2.new(0, 363, 0, 55 + framesize),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 270}
                        ):Play()
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        Dropdown:TweenSize(
                            UDim2.new(0, 363, 0, 42),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                    droptog = not droptog
                end
            )

            for i, v in next, list do
                itemcount = itemcount + 1
                if itemcount <= 3 then
                    framesize = framesize + 26
                    DropItemHolder.Size = UDim2.new(0, 342, 0, framesize)
                end
                local Item = Instance.new("TextButton")
                local ItemCorner = Instance.new("UICorner")

                Item.Name = "Item"
                Item.Parent = DropItemHolder
                Item.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
                Item.ClipsDescendants = true
                Item.Size = UDim2.new(0, 335, 0, 25)
                Item.AutoButtonColor = false
                Item.Font = Enum.Font.Gotham
                Item.Text = v
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 15.000

                ItemCorner.CornerRadius = UDim.new(0, 4)
                ItemCorner.Name = "ItemCorner"
                ItemCorner.Parent = Item

                Item.MouseEnter:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(37, 37, 37)}
                        ):Play()
                    end
                )

                Item.MouseLeave:Connect(
                    function()
                        TweenService:Create(
                            Item,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(34, 34, 34)}
                        ):Play()
                    end
                )

                Item.MouseButton1Click:Connect(
                    function()
                        droptog = not droptog
                        DropdownTitle.Text = text .. " - " .. v
                        pcall(callback, v)
                        Dropdown:TweenSize(
                            UDim2.new(0, 363, 0, 42),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        TweenService:Create(
                            ArrowImg,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {Rotation = 0}
                        ):Play()
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                )

                DropItemHolder.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
            end
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        function tabcontent:Colorpicker(text, preset, callback)
            local ColorPickerToggled = false
            local OldToggleColor = Color3.fromRGB(0, 0, 0)
            local OldColor = Color3.fromRGB(0, 0, 0)
            local OldColorSelectionPosition = nil
            local OldHueSelectionPosition = nil
            local ColorH, ColorS, ColorV = 1, 1, 1
            local RainbowColorPicker = false
            local ColorPickerInput = nil
            local ColorInput = nil
            local HueInput = nil

            local Colorpicker = Instance.new("Frame")
            local ColorpickerCorner = Instance.new("UICorner")
            local ColorpickerTitle = Instance.new("TextLabel")
            local BoxColor = Instance.new("Frame")
            local BoxColorCorner = Instance.new("UICorner")
            local ConfirmBtn = Instance.new("TextButton")
            local ConfirmBtnCorner = Instance.new("UICorner")
            local ConfirmBtnTitle = Instance.new("TextLabel")
            local ColorpickerBtn = Instance.new("TextButton")
            local RainbowToggle = Instance.new("TextButton")
            local RainbowToggleCorner = Instance.new("UICorner")
            local RainbowToggleTitle = Instance.new("TextLabel")
            local FrameRainbowToggle1 = Instance.new("Frame")
            local FrameRainbowToggle1Corner = Instance.new("UICorner")
            local FrameRainbowToggle2 = Instance.new("Frame")
            local FrameRainbowToggle2_2 = Instance.new("UICorner")
            local FrameRainbowToggle3 = Instance.new("Frame")
            local FrameToggle3 = Instance.new("UICorner")
            local FrameRainbowToggleCircle = Instance.new("Frame")
            local FrameRainbowToggleCircleCorner = Instance.new("UICorner")
            local Color = Instance.new("ImageLabel")
            local ColorCorner = Instance.new("UICorner")
            local ColorSelection = Instance.new("ImageLabel")
            local Hue = Instance.new("ImageLabel")
            local HueCorner = Instance.new("UICorner")
            local HueGradient = Instance.new("UIGradient")
            local HueSelection = Instance.new("ImageLabel")

            Colorpicker.Name = "Colorpicker"
            Colorpicker.Parent = Tab
            Colorpicker.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Colorpicker.ClipsDescendants = true
            Colorpicker.Position = UDim2.new(-0.541071415, 0, -0.532915354, 0)
            Colorpicker.Size = UDim2.new(0, 363, 0, 42)

            ColorpickerCorner.CornerRadius = UDim.new(0, 5)
            ColorpickerCorner.Name = "ColorpickerCorner"
            ColorpickerCorner.Parent = Colorpicker

            ColorpickerTitle.Name = "ColorpickerTitle"
            ColorpickerTitle.Parent = Colorpicker
            ColorpickerTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.BackgroundTransparency = 1.000
            ColorpickerTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            ColorpickerTitle.Size = UDim2.new(0, 187, 0, 42)
            ColorpickerTitle.Font = Enum.Font.Gotham
            ColorpickerTitle.Text = text
            ColorpickerTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerTitle.TextSize = 14.000
            ColorpickerTitle.TextXAlignment = Enum.TextXAlignment.Left

            BoxColor.Name = "BoxColor"
            BoxColor.Parent = ColorpickerTitle
            BoxColor.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
            BoxColor.Position = UDim2.new(1.60427809, 0, 0.214285716, 0)
            BoxColor.Size = UDim2.new(0, 41, 0, 23)

            BoxColorCorner.CornerRadius = UDim.new(0, 5)
            BoxColorCorner.Name = "BoxColorCorner"
            BoxColorCorner.Parent = BoxColor

            ConfirmBtn.Name = "ConfirmBtn"
            ConfirmBtn.Parent = ColorpickerTitle
            ConfirmBtn.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            ConfirmBtn.Position = UDim2.new(1.25814295, 0, 1.09037197, 0)
            ConfirmBtn.Size = UDim2.new(0, 105, 0, 32)
            ConfirmBtn.AutoButtonColor = false
            ConfirmBtn.Font = Enum.Font.SourceSans
            ConfirmBtn.Text = ""
            ConfirmBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ConfirmBtn.TextSize = 14.000

            ConfirmBtnCorner.CornerRadius = UDim.new(0, 5)
            ConfirmBtnCorner.Name = "ConfirmBtnCorner"
            ConfirmBtnCorner.Parent = ConfirmBtn

            ConfirmBtnTitle.Name = "ConfirmBtnTitle"
            ConfirmBtnTitle.Parent = ConfirmBtn
            ConfirmBtnTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmBtnTitle.BackgroundTransparency = 1.000
            ConfirmBtnTitle.Size = UDim2.new(0, 33, 0, 32)
            ConfirmBtnTitle.Font = Enum.Font.Gotham
            ConfirmBtnTitle.Text = "Confirm"
            ConfirmBtnTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ConfirmBtnTitle.TextSize = 14.000
            ConfirmBtnTitle.TextXAlignment = Enum.TextXAlignment.Left

            ColorpickerBtn.Name = "ColorpickerBtn"
            ColorpickerBtn.Parent = ColorpickerTitle
            ColorpickerBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorpickerBtn.BackgroundTransparency = 1.000
            ColorpickerBtn.Size = UDim2.new(0, 363, 0, 42)
            ColorpickerBtn.Font = Enum.Font.SourceSans
            ColorpickerBtn.Text = ""
            ColorpickerBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
            ColorpickerBtn.TextSize = 14.000

            RainbowToggle.Name = "RainbowToggle"
            RainbowToggle.Parent = ColorpickerTitle
            RainbowToggle.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            RainbowToggle.Position = UDim2.new(1.26349044, 0, 2.12684202, 0)
            RainbowToggle.Size = UDim2.new(0, 104, 0, 32)
            RainbowToggle.AutoButtonColor = false
            RainbowToggle.Font = Enum.Font.SourceSans
            RainbowToggle.Text = ""
            RainbowToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            RainbowToggle.TextSize = 14.000

            RainbowToggleCorner.CornerRadius = UDim.new(0, 5)
            RainbowToggleCorner.Name = "RainbowToggleCorner"
            RainbowToggleCorner.Parent = RainbowToggle

            RainbowToggleTitle.Name = "RainbowToggleTitle"
            RainbowToggleTitle.Parent = RainbowToggle
            RainbowToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            RainbowToggleTitle.BackgroundTransparency = 1.000
            RainbowToggleTitle.Size = UDim2.new(0, 33, 0, 32)
            RainbowToggleTitle.Font = Enum.Font.Gotham
            RainbowToggleTitle.Text = "Rainbow"
            RainbowToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            RainbowToggleTitle.TextSize = 14.000
            RainbowToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

            FrameRainbowToggle1.Name = "FrameRainbowToggle1"
            FrameRainbowToggle1.Parent = RainbowToggle
            FrameRainbowToggle1.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            FrameRainbowToggle1.Position = UDim2.new(0.649999976, 0, 0.186000004, 0)
            FrameRainbowToggle1.Size = UDim2.new(0, 37, 0, 18)

            FrameRainbowToggle1Corner.Name = "FrameRainbowToggle1Corner"
            FrameRainbowToggle1Corner.Parent = FrameRainbowToggle1

            FrameRainbowToggle2.Name = "FrameRainbowToggle2"
            FrameRainbowToggle2.Parent = FrameRainbowToggle1
            FrameRainbowToggle2.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            FrameRainbowToggle2.Position = UDim2.new(0.0590000004, 0, 0.112999998, 0)
            FrameRainbowToggle2.Size = UDim2.new(0, 33, 0, 14)

            FrameRainbowToggle2_2.Name = "FrameRainbowToggle2"
            FrameRainbowToggle2_2.Parent = FrameRainbowToggle2

            FrameRainbowToggle3.Name = "FrameRainbowToggle3"
            FrameRainbowToggle3.Parent = FrameRainbowToggle1
            FrameRainbowToggle3.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            FrameRainbowToggle3.BackgroundTransparency = 1.000
            FrameRainbowToggle3.Size = UDim2.new(0, 37, 0, 18)

            FrameToggle3.Name = "FrameToggle3"
            FrameToggle3.Parent = FrameRainbowToggle3

            FrameRainbowToggleCircle.Name = "FrameRainbowToggleCircle"
            FrameRainbowToggleCircle.Parent = FrameRainbowToggle1
            FrameRainbowToggleCircle.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            FrameRainbowToggleCircle.Position = UDim2.new(0.127000004, 0, 0.222000003, 0)
            FrameRainbowToggleCircle.Size = UDim2.new(0, 10, 0, 10)

            FrameRainbowToggleCircleCorner.Name = "FrameRainbowToggleCircleCorner"
            FrameRainbowToggleCircleCorner.Parent = FrameRainbowToggleCircle

            Color.Name = "Color"
            Color.Parent = ColorpickerTitle
            Color.BackgroundColor3 = Color3.fromRGB(255, 0, 4)
            Color.Position = UDim2.new(0, 0, 0, 42)
            Color.Size = UDim2.new(0, 194, 0, 80)
            Color.ZIndex = 10
            Color.Image = "rbxassetid://4155801252"
            Color.Active = true

            ColorCorner.CornerRadius = UDim.new(0, 3)
            ColorCorner.Name = "ColorCorner"
            ColorCorner.Parent = Color

            ColorSelection.Name = "ColorSelection"
            ColorSelection.Parent = Color
            ColorSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            ColorSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ColorSelection.BackgroundTransparency = 1.000
            ColorSelection.Position = UDim2.new(preset and select(3, Color3.toHSV(preset)))
            ColorSelection.Size = UDim2.new(0, 18, 0, 18)
            ColorSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            ColorSelection.ScaleType = Enum.ScaleType.Fit
            ColorSelection.Visible = false

            Hue.Name = "Hue"
            Hue.Parent = ColorpickerTitle
            Hue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hue.Position = UDim2.new(0, 202, 0, 42)
            Hue.Size = UDim2.new(0, 25, 0, 80)
            Hue.Active = true

            HueCorner.CornerRadius = UDim.new(0, 3)
            HueCorner.Name = "HueCorner"
            HueCorner.Parent = Hue

            HueGradient.Color =
                ColorSequence.new {
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 0, 4)),
                ColorSequenceKeypoint.new(0.20, Color3.fromRGB(234, 255, 0)),
                ColorSequenceKeypoint.new(0.40, Color3.fromRGB(21, 255, 0)),
                ColorSequenceKeypoint.new(0.60, Color3.fromRGB(0, 255, 255)),
                ColorSequenceKeypoint.new(0.80, Color3.fromRGB(0, 17, 255)),
                ColorSequenceKeypoint.new(0.90, Color3.fromRGB(255, 0, 251)),
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(255, 0, 4))
            }
            HueGradient.Rotation = 270
            HueGradient.Name = "HueGradient"
            HueGradient.Parent = Hue

            HueSelection.Name = "HueSelection"
            HueSelection.Parent = Hue
            HueSelection.AnchorPoint = Vector2.new(0.5, 0.5)
            HueSelection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            HueSelection.BackgroundTransparency = 1.000
            HueSelection.Position = UDim2.new(0.48, 0, 1 - select(1, Color3.toHSV(preset)))
            HueSelection.Size = UDim2.new(0, 18, 0, 18)
            HueSelection.Image = "http://www.roblox.com/asset/?id=4805639000"
            HueSelection.Visible = false

            coroutine.wrap(
                function()
                    while wait() do
                        FrameRainbowToggle3.BackgroundColor3 = PresetColor
                    end
                end
            )()

            ColorpickerBtn.MouseButton1Click:Connect(
                function()
                    if ColorPickerToggled == false then
                        ColorSelection.Visible = true
                        HueSelection.Visible = true
                        Colorpicker:TweenSize(
                            UDim2.new(0, 363, 0, 132),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    else
                        ColorSelection.Visible = false
                        HueSelection.Visible = false
                        Colorpicker:TweenSize(
                            UDim2.new(0, 363, 0, 42),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )
                        wait(.2)
                        Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                    end
                    ColorPickerToggled = not ColorPickerToggled
                end
            )

            local function UpdateColorPicker(nope)
                BoxColor.BackgroundColor3 = Color3.fromHSV(ColorH, ColorS, ColorV)
                Color.BackgroundColor3 = Color3.fromHSV(ColorH, 1, 1)

                pcall(callback, BoxColor.BackgroundColor3)
            end

            ColorH =
                1 -
                (math.clamp(HueSelection.AbsolutePosition.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                    Hue.AbsoluteSize.Y)
            ColorS =
                (math.clamp(ColorSelection.AbsolutePosition.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                Color.AbsoluteSize.X)
            ColorV =
                1 -
                (math.clamp(ColorSelection.AbsolutePosition.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                    Color.AbsoluteSize.Y)

            BoxColor.BackgroundColor3 = preset
            Color.BackgroundColor3 = preset
            pcall(callback, BoxColor.BackgroundColor3)

            local function UpdateColorFromPosition(pos)
                local ColorX =
                    (math.clamp(pos.X - Color.AbsolutePosition.X, 0, Color.AbsoluteSize.X) /
                    Color.AbsoluteSize.X)
                local ColorY =
                    (math.clamp(pos.Y - Color.AbsolutePosition.Y, 0, Color.AbsoluteSize.Y) /
                    Color.AbsoluteSize.Y)

                ColorSelection.Position = UDim2.new(ColorX, 0, ColorY, 0)
                ColorS = ColorX
                ColorV = 1 - ColorY

                UpdateColorPicker(true)
            end

            Color.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        if RainbowColorPicker then
                            return
                        end

                        if ColorInput then
                            ColorInput:Disconnect()
                        end

                        -- move immediately to the tap/click point, then track drags.
                        -- input.Position (not the desktop-only Mouse object) works for both mouse and touch.
                        UpdateColorFromPosition(input.Position)

                        ColorInput =
                            UserInputService.InputChanged:Connect(
                            function(movedInput)
                                if
                                    movedInput.UserInputType == Enum.UserInputType.MouseMovement or
                                        movedInput.UserInputType == Enum.UserInputType.Touch
                                 then
                                    UpdateColorFromPosition(movedInput.Position)
                                end
                            end
                        )
                    end
                end
            )

            Color.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        if ColorInput then
                            ColorInput:Disconnect()
                        end
                    end
                end
            )

            local function UpdateHueFromPosition(pos)
                local HueY =
                    (math.clamp(pos.Y - Hue.AbsolutePosition.Y, 0, Hue.AbsoluteSize.Y) /
                    Hue.AbsoluteSize.Y)

                HueSelection.Position = UDim2.new(0.48, 0, HueY, 0)
                ColorH = 1 - HueY

                UpdateColorPicker(true)
            end

            Hue.InputBegan:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        if RainbowColorPicker then
                            return
                        end

                        if HueInput then
                            HueInput:Disconnect()
                        end

                        UpdateHueFromPosition(input.Position)

                        HueInput =
                            UserInputService.InputChanged:Connect(
                            function(movedInput)
                                if
                                    movedInput.UserInputType == Enum.UserInputType.MouseMovement or
                                        movedInput.UserInputType == Enum.UserInputType.Touch
                                 then
                                    UpdateHueFromPosition(movedInput.Position)
                                end
                            end
                        )
                    end
                end
            )

            Hue.InputEnded:Connect(
                function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        if HueInput then
                            HueInput:Disconnect()
                        end
                    end
                end
            )

            RainbowToggle.MouseButton1Down:Connect(
                function()
                    RainbowColorPicker = not RainbowColorPicker

                    if ColorInput then
                        ColorInput:Disconnect()
                    end

                    if HueInput then
                        HueInput:Disconnect()
                    end

                    if RainbowColorPicker then
                        TweenService:Create(
                            FrameRainbowToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(255, 255, 255)}
                        ):Play()
                        FrameRainbowToggleCircle:TweenPosition(
                            UDim2.new(0.587, 0, 0.222000003, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )

                        OldToggleColor = BoxColor.BackgroundColor3
                        OldColor = Color.BackgroundColor3
                        OldColorSelectionPosition = ColorSelection.Position
                        OldHueSelectionPosition = HueSelection.Position

                        while RainbowColorPicker do
                            BoxColor.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)
                            Color.BackgroundColor3 = Color3.fromHSV(lib.RainbowColorValue, 1, 1)

                            ColorSelection.Position = UDim2.new(1, 0, 0, 0)
                            HueSelection.Position = UDim2.new(0.48, 0, 0, lib.HueSelectionPosition)

                            pcall(callback, BoxColor.BackgroundColor3)
                            wait()
                        end
                    elseif not RainbowColorPicker then
                        TweenService:Create(
                            FrameRainbowToggle1,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle2,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 0}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggle3,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundTransparency = 1}
                        ):Play()
                        TweenService:Create(
                            FrameRainbowToggleCircle,
                            TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(50, 50, 50)}
                        ):Play()
                        FrameRainbowToggleCircle:TweenPosition(
                            UDim2.new(0.127000004, 0, 0.222000003, 0),
                            Enum.EasingDirection.Out,
                            Enum.EasingStyle.Quart,
                            .2,
                            true
                        )

                        BoxColor.BackgroundColor3 = OldToggleColor
                        Color.BackgroundColor3 = OldColor

                        ColorSelection.Position = OldColorSelectionPosition
                        HueSelection.Position = OldHueSelectionPosition

                        pcall(callback, BoxColor.BackgroundColor3)
                    end
                end
            )

            ConfirmBtn.MouseButton1Click:Connect(
                function()
                    ColorSelection.Visible = false
                    HueSelection.Visible = false
                    Colorpicker:TweenSize(
                        UDim2.new(0, 363, 0, 42),
                        Enum.EasingDirection.Out,
                        Enum.EasingStyle.Quart,
                        .2,
                        true
                    )
                    wait(.2)
                    Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
                end
            )
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        function tabcontent:Label(text)
            local Label = Instance.new("TextButton")
            local LabelCorner = Instance.new("UICorner")
            local LabelTitle = Instance.new("TextLabel")

            Label.Name = "Button"
            Label.Parent = Tab
            Label.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Label.Size = UDim2.new(0, 363, 0, 42)
            Label.AutoButtonColor = false
            Label.Font = Enum.Font.SourceSans
            Label.Text = ""
            Label.TextColor3 = Color3.fromRGB(0, 0, 0)
            Label.TextSize = 14.000

            LabelCorner.CornerRadius = UDim.new(0, 5)
            LabelCorner.Name = "ButtonCorner"
            LabelCorner.Parent = Label

            LabelTitle.Name = "ButtonTitle"
            LabelTitle.Parent = Label
            LabelTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.BackgroundTransparency = 1.000
            LabelTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            LabelTitle.Size = UDim2.new(0, 187, 0, 42)
            LabelTitle.Font = Enum.Font.Gotham
            LabelTitle.Text = text
            LabelTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            LabelTitle.TextSize = 14.000
            LabelTitle.TextXAlignment = Enum.TextXAlignment.Left

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        -- tabcontent:Paragraph(title, text, avatar)
        --   A card with a bold title and a wrapped body of text below it.
        --   avatar is optional: pass a Roblox userId (number) or username
        --   (string) and a circular avatar thumbnail is shown on the left.
        function tabcontent:Paragraph(title, text, avatar)
            local TextService = game:GetService("TextService")

            local hasAvatar = avatar ~= nil and avatar ~= false
            local leftInset = hasAvatar and 63 or 13
            local textWidth = 363 - leftInset - 13

            -- Measured line-by-line (rather than passing the whole multi-line
            -- string to GetTextSize at once) so manual "\n" breaks combined
            -- with word-wrap always add up to the exact height needed, plus
            -- a small buffer so the last line never gets clipped.
            local function MeasureHeight(str, size, font)
                local total = 0
                for _, line in ipairs(str:split("\n")) do
                    total = total + TextService:GetTextSize(line, size, font, Vector2.new(textWidth, math.huge)).Y
                end
                return total + 4
            end

            local titleHeight = MeasureHeight(title, 14, Enum.Font.GothamBold)
            local textHeight = MeasureHeight(text, 13, Enum.Font.Gotham)

            local contentHeight = 13 + titleHeight + 4 + textHeight + 13
            local cardHeight = math.max(contentHeight, hasAvatar and 68 or 0, 42)

            local Paragraph = Instance.new("Frame")
            local ParagraphCorner = Instance.new("UICorner")
            local ParagraphTitle = Instance.new("TextLabel")
            local ParagraphText = Instance.new("TextLabel")

            Paragraph.Name = "Paragraph"
            Paragraph.Parent = Tab
            Paragraph.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Paragraph.Size = UDim2.new(0, 363, 0, cardHeight)

            ParagraphCorner.CornerRadius = UDim.new(0, 5)
            ParagraphCorner.Name = "ParagraphCorner"
            ParagraphCorner.Parent = Paragraph

            if hasAvatar then
                local userId = avatar
                if typeof(avatar) == "string" then
                    local success, id =
                        pcall(
                        function()
                            return game:GetService("Players"):GetUserIdFromNameAsync(avatar)
                        end
                    )
                    userId = success and id or 1
                end

                local AvatarImage = Instance.new("ImageLabel")
                local AvatarCorner = Instance.new("UICorner")

                AvatarImage.Name = "AvatarImage"
                AvatarImage.Parent = Paragraph
                AvatarImage.BackgroundTransparency = 1.000
                AvatarImage.Position = UDim2.new(0, 13, 0, 13)
                AvatarImage.Size = UDim2.new(0, 42, 0, 42)
                AvatarImage.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(userId) .. "&w=150&h=150"

                AvatarCorner.CornerRadius = UDim.new(1, 0)
                AvatarCorner.Name = "AvatarCorner"
                AvatarCorner.Parent = AvatarImage
            end

            ParagraphTitle.Name = "ParagraphTitle"
            ParagraphTitle.Parent = Paragraph
            ParagraphTitle.BackgroundTransparency = 1.000
            ParagraphTitle.Position = UDim2.new(0, leftInset, 0, 13)
            ParagraphTitle.Size = UDim2.new(0, textWidth, 0, titleHeight)
            ParagraphTitle.Font = Enum.Font.GothamBold
            ParagraphTitle.Text = title
            ParagraphTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            ParagraphTitle.TextSize = 14.000
            ParagraphTitle.TextWrapped = true
            ParagraphTitle.TextXAlignment = Enum.TextXAlignment.Left
            ParagraphTitle.TextYAlignment = Enum.TextYAlignment.Top

            ParagraphText.Name = "ParagraphText"
            ParagraphText.Parent = Paragraph
            ParagraphText.BackgroundTransparency = 1.000
            ParagraphText.Position = UDim2.new(0, leftInset, 0, 13 + titleHeight + 4)
            ParagraphText.Size = UDim2.new(0, textWidth, 0, textHeight)
            ParagraphText.Font = Enum.Font.Gotham
            ParagraphText.Text = text
            ParagraphText.TextColor3 = Color3.fromRGB(200, 200, 200)
            ParagraphText.TextSize = 13.000
            ParagraphText.TextWrapped = true
            ParagraphText.TextXAlignment = Enum.TextXAlignment.Left
            ParagraphText.TextYAlignment = Enum.TextYAlignment.Top

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        function tabcontent:Textbox(text, disapper, callback)
            local Textbox = Instance.new("Frame")
            local TextboxCorner = Instance.new("UICorner")
            local TextboxTitle = Instance.new("TextLabel")
            local TextboxFrame = Instance.new("Frame")
            local TextboxFrameCorner = Instance.new("UICorner")
            local TextBox = Instance.new("TextBox")

            Textbox.Name = "Textbox"
            Textbox.Parent = Tab
            Textbox.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Textbox.ClipsDescendants = true
            Textbox.Position = UDim2.new(-0.541071415, 0, -0.532915354, 0)
            Textbox.Size = UDim2.new(0, 363, 0, 42)

            TextboxCorner.CornerRadius = UDim.new(0, 5)
            TextboxCorner.Name = "TextboxCorner"
            TextboxCorner.Parent = Textbox

            TextboxTitle.Name = "TextboxTitle"
            TextboxTitle.Parent = Textbox
            TextboxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.BackgroundTransparency = 1.000
            TextboxTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            TextboxTitle.Size = UDim2.new(0, 187, 0, 42)
            TextboxTitle.Font = Enum.Font.Gotham
            TextboxTitle.Text = text
            TextboxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextboxTitle.TextSize = 14.000
            TextboxTitle.TextXAlignment = Enum.TextXAlignment.Left

            TextboxFrame.Name = "TextboxFrame"
            TextboxFrame.Parent = TextboxTitle
            TextboxFrame.BackgroundColor3 = Color3.fromRGB(37, 37, 37)
            TextboxFrame.Position = UDim2.new(1.28877008, 0, 0.214285716, 0)
            TextboxFrame.Size = UDim2.new(0, 100, 0, 23)

            TextboxFrameCorner.CornerRadius = UDim.new(0, 5)
            TextboxFrameCorner.Name = "TextboxFrameCorner"
            TextboxFrameCorner.Parent = TextboxFrame

            TextBox.Parent = TextboxFrame
            TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.BackgroundTransparency = 1.000
            TextBox.Size = UDim2.new(0, 100, 0, 23)
            TextBox.Font = Enum.Font.Gotham
            TextBox.Text = ""
            TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextBox.TextSize = 14.000

            TextBox.FocusLost:Connect(
                function(ep)
                    if ep then
                        if #TextBox.Text > 0 then
                            pcall(callback, TextBox.Text)
                            if disapper then
                                TextBox.Text = ""
                            end
                        end
                    end
                end
            )
            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)
        end
        function tabcontent:Bind(text, keypreset, callback)
            local binding = false
            local Key = keypreset.Name
            local Bind = Instance.new("TextButton")
            local BindCorner = Instance.new("UICorner")
            local BindTitle = Instance.new("TextLabel")
            local BindText = Instance.new("TextLabel")

            Bind.Name = "Bind"
            Bind.Parent = Tab
            Bind.BackgroundColor3 = Color3.fromRGB(34, 34, 34)
            Bind.Size = UDim2.new(0, 363, 0, 42)
            Bind.AutoButtonColor = false
            Bind.Font = Enum.Font.SourceSans
            Bind.Text = ""
            Bind.TextColor3 = Color3.fromRGB(0, 0, 0)
            Bind.TextSize = 14.000

            BindCorner.CornerRadius = UDim.new(0, 5)
            BindCorner.Name = "BindCorner"
            BindCorner.Parent = Bind

            BindTitle.Name = "BindTitle"
            BindTitle.Parent = Bind
            BindTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.BackgroundTransparency = 1.000
            BindTitle.Position = UDim2.new(0.0358126722, 0, 0, 0)
            BindTitle.Size = UDim2.new(0, 187, 0, 42)
            BindTitle.Font = Enum.Font.Gotham
            BindTitle.Text = text
            BindTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindTitle.TextSize = 14.000
            BindTitle.TextXAlignment = Enum.TextXAlignment.Left

            BindText.Name = "BindText"
            BindText.Parent = Bind
            BindText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            BindText.BackgroundTransparency = 1.000
            BindText.Position = UDim2.new(0.0358126722, 0, 0, 0)
            BindText.Size = UDim2.new(0, 337, 0, 42)
            BindText.Font = Enum.Font.Gotham
            BindText.Text = Key
            BindText.TextColor3 = Color3.fromRGB(255, 255, 255)
            BindText.TextSize = 14.000
            BindText.TextXAlignment = Enum.TextXAlignment.Right

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

            Bind.MouseButton1Click:Connect(
                function()
                    BindText.Text = "..."
                    binding = true
                    local inputwait = game:GetService("UserInputService").InputBegan:wait()
                    if inputwait.KeyCode.Name ~= "Unknown" then
                        BindText.Text = inputwait.KeyCode.Name
                        Key = inputwait.KeyCode.Name
                        binding = false
                    else
                        binding = false
                    end
                end
            )

            game:GetService("UserInputService").InputBegan:connect(
                function(current, pressed)
                    if not pressed then
                        if current.KeyCode.Name == Key and binding == false then
                            pcall(callback)
                        end
                    end
                end
            )
        end
        function tabcontent:Section(text)
            -- extra breathing room above the section, but not if it's the
            -- very first thing added to the tab (Tab always has TabLayout
            -- as a child, so 1 child means nothing's been added yet)
            if #Tab:GetChildren() > 1 then
                local SectionSpacing = Instance.new("Frame")
                SectionSpacing.Name = "SectionSpacing"
                SectionSpacing.Parent = Tab
                SectionSpacing.BackgroundTransparency = 1.000
                SectionSpacing.Size = UDim2.new(0, 363, 0, 8)
            end

            local Section = Instance.new("TextLabel")

            Section.Name = "Section"
            Section.Parent = Tab
            Section.BackgroundTransparency = 1.000
            Section.Size = UDim2.new(0, 363, 0, 20)
            Section.Font = Enum.Font.GothamBold
            Section.Text = text
            Section.TextColor3 = PresetColor
            Section.TextSize = 13.000
            Section.TextXAlignment = Enum.TextXAlignment.Left
            Section.TextTransparency = 1.000

            coroutine.wrap(
                function()
                    while wait() do
                        Section.TextColor3 = PresetColor
                    end
                end
            )()

            TweenService:Create(
                Section,
                TweenInfo.new(.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
                {TextTransparency = 0}
            ):Play()

            Tab.CanvasSize = UDim2.new(0, 0, 0, TabLayout.AbsoluteContentSize.Y)

            local SectionValue = {}
            function SectionValue:Set(newText)
                Section.Text = newText
            end
            return SectionValue
        end
        return tabcontent
    end
    return tabhold
end
return lib
