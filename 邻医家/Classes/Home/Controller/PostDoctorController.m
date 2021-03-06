//
//  PostDoctorController.m
//  邻医家
//
//  Created by Daniel on 15/5/11.
//  Copyright (c) 2015年 DanielGrason. All rights reserved.
//
#import "StationListResult.h"
#import "PostDocParam.h"
#import "SearchRecruitTool.h"
#import "LDSearchSubjectController.h"
#import "LDNotification.h"
#import "DoctorStationDetailController.h"
#import "PostDoctorController.h"
#import "Common.h"
#import "StationListResult.h"
#import "MultiJobCell.h"
#import "DoctorStationListTool.h"
#import "DoctorStation.h"
@interface PostDoctorController () <UISearchBarDelegate>
@property (nonatomic,strong) NSMutableArray *stations;
@property (nonatomic,weak) UISearchBar *searchBar;
@end

@implementation PostDoctorController
- (NSMutableArray *)stations
{
    if (_stations == nil) {
        _stations = [NSMutableArray array];
    }
    return _stations;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self loadData];
}
- (void)loadData
{
    [DoctorStationListTool doctorStationListSuccess:^(StationListResult *result) {
        if ([result.status isEqualToString:SUCCESSSTATUS]) {
            [self.stations addObjectsFromArray:result.postdoctorStations];
            [self.tableView reloadData];
        }else{
            
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)setup
{
    self.navigationItem.rightBarButtonItem = nil;
    self.navigationItem.title = @"博士后站点";
    [DefaultCenter addObserver:self selector:@selector(searchDepartment:) name:SUBJECTCHOSSEDNOTIFICATION object:nil];
    [self setupSearchBar];
}
- (void)dealloc
{
    [DefaultCenter removeObserver:self];
}
- (void)setupSearchBar
{
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 30)];
    searchBar.delegate = self;
    searchBar.placeholder = @"热门学科";
    self.tableView.tableHeaderView = searchBar;
    self.searchBar = searchBar;
}
#pragma mark - tableview delegate and datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.stations.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MultiJobCell *cell = [MultiJobCell cellWithTableView:tableView];
    cell.doctorStation = self.stations[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DoctorStationDetailController *detailVC = [[DoctorStationDetailController alloc] init];
    detailVC.doctorStation = self.stations[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
}
#pragma mark - searchbar delegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    LDSearchSubjectController *searchVC = [[LDSearchSubjectController alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
    return NO;
}
#pragma mark - Notificaiton
- (void)searchDepartment:(NSNotification *)notification
{
    self.searchBar.text = notification.userInfo[@"subjectName"];
    PostDocParam *param = [PostDocParam paramWithDirection:notification.userInfo[@"subjectId"]];
 
    [SearchRecruitTool searchDoctorStationWithParam:param success:^(StationListResult *result) {
        if ([result.status isEqualToString:SUCCESSSTATUS]) {
            if (self.stations.count) {
                [self.stations removeAllObjects];
            }
            [self.stations addObjectsFromArray:result.postdoctorStations];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
@end








