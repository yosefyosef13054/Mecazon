import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mecazone/model/Subscription/subscription_data_model.dart';

class SubscriptionListBindings extends Bindings{
  @override
  void dependencies() {
    Get.put(SubscriptionListController());
  }
}

class SubscriptionListController extends GetxController {
  final vnIsShowLoader = false.obs;
  var lstSubscription = <SubscriptionList>[].obs;
  late PageController pageController;
  var currentPageValue = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  onClose() {

  }

  _init() {
    pageController = PageController(initialPage: 0, keepPage: false, viewportFraction: 1);

    lstSubscription.add(
      SubscriptionList(
        subscriptionName: "Starter",
        storageNb: 15,
        subscriptionId: 1,
        website: false,
        certifiedStore: false,
        postRequest: false,
        priorityStore: false,
        colorCode: "",
        image: "",
        planDetails: [
          PlanDetails(
            name: "1 Month",
            planId: 1,
            price: "1000 DA"
          ),
          PlanDetails(
              name: "6 Month",
              planId: 2,
              price: "2000 DA"
          ),
          PlanDetails(
              name: "1 Year",
              planId: 3,
              price: "5000 DA"
          ),
        ]
      )
    );

    lstSubscription.add(
        SubscriptionList(
            subscriptionName: "Basic",
            storageNb: 30,
            subscriptionId: 2,
            website: true,
            certifiedStore: true,
            postRequest: true,
            priorityStore: true,
            colorCode: "",
            image: "",
            planDetails: [
              PlanDetails(
                  name: "3 Month",
                  planId: 4,
                  price: "2000 DA"
              ),
              PlanDetails(
                  name: "6 Month",
                  planId: 5,
                  price: "4000 DA"
              ),
              PlanDetails(
                  name: "1 Year",
                  planId: 6,
                  price: "6000 DA"
              ),
            ]
        )
    );

    lstSubscription.add(
        SubscriptionList(
            subscriptionName: "Starter",
            storageNb: 15,
            subscriptionId: 1,
            website: false,
            certifiedStore: false,
            postRequest: false,
            priorityStore: false,
            colorCode: "",
            image: "",
            planDetails: [
              PlanDetails(
                  name: "1 Month",
                  planId: 1,
                  price: "1000 DA"
              ),
              PlanDetails(
                  name: "6 Month",
                  planId: 2,
                  price: "2000 DA"
              ),
              PlanDetails(
                  name: "1 Year",
                  planId: 3,
                  price: "5000 DA"
              ),
            ]
        )
    );

    lstSubscription.add(
        SubscriptionList(
            subscriptionName: "Basic",
            storageNb: 30,
            subscriptionId: 2,
            website: true,
            certifiedStore: true,
            postRequest: true,
            priorityStore: true,
            colorCode: "",
            image: "",
            planDetails: [
              PlanDetails(
                  name: "3 Month",
                  planId: 4,
                  price: "2000 DA"
              ),
              PlanDetails(
                  name: "6 Month",
                  planId: 5,
                  price: "4000 DA"
              ),
              PlanDetails(
                  name: "1 Year",
                  planId: 6,
                  price: "6000 DA"
              ),
            ]
        )
    );

    update();
  }

  onChangePage(int index){
    currentPageValue.value = index.toDouble();
    update();
  }

  /// : CALL SUBSCRIPTION LIST API
  callGetSubscriptionListAPI(){

  }

  /// : CALL BOOK SUBSCRIPTION API
  callBookSubscriptionAPI(){

  }

}

