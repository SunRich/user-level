package service

import (
	"accountlevel"
)

type AccountLevel struct {
}

func (a *AccountLevel) AddAccount(uid int32, account float64) (r bool, err error) {
	return
}
func (a *AccountLevel) GetUserAccountLevel(uid int32) (r *accountlevel.Userlevel, err error) {
	return
}
func (a *AccountLevel) GetUserDiscount(uid int32) (r float64, err error) {
	return
}
