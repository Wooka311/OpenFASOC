 
STARRCXT_CCP_VERSION: 3.8.18

* CCP_INSTALL_PATH = path to CCP binary
* CCP_INSTALL_PATH/ccp_<operating system> 
STARRCXT_CCP_EXECUTABLE: ccp_redhat

STARRCXT_INTERFACE_VIA_LAYERS: via0gcn via0tcn viaf
STARRCXT_INTERFACE_CONDUCTOR_LAYERS: m1 m2

* FILE_PROCESS_RCM = path to rc_model_map
RCMODEL_MAP_FILE: rc_model_map

XGUNC_WINDOW_SIZE: 7.5
XGUNC_GUARD_BAND: 0.5

CCP_INFO_LEVEL: 9
SMALL_FEATURE_CUTOFF: 0.001

RV_FIN_NUMBER_PRINT: ON

* FILE_PROCESS_BE_UPF = path to be.upf
UPF_FILE: be.upf

RPLUSC_OUTPUT_PRINT: OFF
XOUT_OUTPUT_PRINT: OFF
RESISTANCE_SCATTERING_MODEL: ON

CLOSE_BULK_PIN_OPENS: OFF

* Substrate and base layer processing
NWELL_DBLAYER_NAMES: nwell_nores_2txt nwell_nores
DEEP_NWELL_DBLAYER_NAMES: DEEPNWELL dnpdnw_cathode dpndnw_cathode deep_nwell nwell_dnw_nores
PWELL_DBLAYER_NAMES: dnpdnw_anode pwell_ext subiso isopwell
SUBSTRATE_DBLAYER_NAMES: ndev_bulk __drsubstrate __drSubstrate subiso virpwell pwell_ext __drWaferSub pwellPhysicalConnector
FTI_DBLAYER_NAMES: FTI
BULK_PIN_CONNECT: ON
